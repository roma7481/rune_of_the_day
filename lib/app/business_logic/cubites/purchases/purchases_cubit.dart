import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:meta/meta.dart';
import 'package:rune_of_the_day/app/services/premium/premium_controller.dart';

part 'purchases_state.dart';

class PurchasesCubit extends Cubit<PurchasesState> {
  StreamSubscription<List<PurchaseDetails>> _subscription;
  InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  ProductDetails _productDetails;
  String _price;

  PurchasesCubit() : super(PurchasesInitLoading()) {
    emitInitPurchases();
  }

  String get price => _price;

  void emitInitPurchases() async {
    Stream purchaseUpdates =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdates.listen((purchases) {
      _listenToPurchaseUpdated(purchases);
    });

    final bool available = await _connection.isAvailable();
    if (!available) {
      emit(PurchasesInitError());
    }

    const Set<String> _kIds = {'tarot_card_premium'};
    final ProductDetailsResponse response =
        await InAppPurchaseConnection.instance.queryProductDetails(_kIds);
    if (response.notFoundIDs.isNotEmpty) {
      emit(PurchasesInitError());
    }
    _productDetails = response.productDetails.first;
    _price = _productDetails.price;
    _checkPastPurchases();
    emit(PurchasesInitSuccess(productDetails: _productDetails));
  }

  Future<void> restorePurchases() async {
    await _checkPastPurchases();
    emit(PurchasesRestored());
  }

  Future<void> _checkPastPurchases() async {
    PremiumController.instance.disablePremium();

    final QueryPurchaseDetailsResponse response =
        await InAppPurchaseConnection.instance.queryPastPurchases();
    if (response.error != null) {
      emit(PurchasesInitError());
    }
    for (PurchaseDetails purchase in response.pastPurchases) {
      if (Platform.isIOS) {
        InAppPurchaseConnection.instance.completePurchase(purchase);
      }

      if (purchase.status == PurchaseStatus.purchased) {
        PremiumController.instance.enablePremium();
      } else {
        PremiumController.instance.disablePremium();
      }
    }
  }

  Future<void> emitBuyProduct() async {
    PurchaseParam purchaseParam = PurchaseParam(
      productDetails: _productDetails,
      applicationUserName: null,
    );

    await _connection.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        emit(PurchasesLoading());
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          emit(PurchasesCanceled());
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          PremiumController.instance.enablePremium();
          emit(PurchasesSuccess());
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchaseConnection.instance
              .completePurchase(purchaseDetails);
        }
      }
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
