import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:meta/meta.dart';
import 'package:rune_of_the_day/app/services/premium/premium_controller.dart';

part 'purchases_state.dart';

class PurchasesCubit extends Cubit<PurchasesState> {
  static const productName = 'rune_premium';
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  InAppPurchase _connection = InAppPurchase.instance;
  late ProductDetails _productDetails;
  String? _price;

  PurchasesCubit() : super(PurchasesLoading()) {
    emitInitPurchases();
  }

  String? get price => _price;

  void emitInitPurchases() async {
    Stream purchaseUpdates = _connection.purchaseStream;
    _subscription = purchaseUpdates.listen((purchases) {
      _listenToPurchaseUpdated(purchases);
    }) as StreamSubscription<List<PurchaseDetails>>;

    final bool available = await _connection.isAvailable();
    if (!available) {
      emit(PurchasesInitFailed());
    }

    const Set<String> _kIds = {productName};
    final ProductDetailsResponse response =
    await _connection.queryProductDetails(_kIds);
    if (response.notFoundIDs.isNotEmpty) {
      emit(PurchasesInitFailed());
    }
    _productDetails = response.productDetails.first;
    _price = _productDetails.price;
    await _connection.restorePurchases();
    emit(PurchasesReady());
  }

  Future<void> emitBuyProduct() async {
    PurchaseParam purchaseParam = PurchaseParam(
      productDetails: _productDetails,
      applicationUserName: null,
    );
    await _connection.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> restorePurchases() async {
    await _connection.restorePurchases();
    emit(PurchasesRestored());
  }

  Future<void> _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        emit(PurchasesLoading());
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          PremiumController.instance.disablePremium();
          emit(PurchasesError());
        } else if (purchaseDetails.status == PurchaseStatus.canceled) {
          PremiumController.instance.disablePremium();
          emit(PurchasesCanceled());
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          PremiumController.instance.enablePremium();
          emit(PurchasesSuccess());
        } else if (purchaseDetails.status == PurchaseStatus.restored) {
          if (purchaseDetails.error != null) {
            PremiumController.instance.disablePremium();
            emit(PurchasesError());
          }
          _verifyPurchase(purchaseDetailsList);
        } else {
          emit(PurchasesReady());
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _connection.completePurchase(purchaseDetails);
        }
      }
    });
  }

  Future<void> _verifyPurchase(List<PurchaseDetails> purchaseDetails) async {
    for (PurchaseDetails purchase in purchaseDetails) {
      if(purchase.productID == productName){
        await PremiumController.instance.enablePremium();
        emit(PurchasesSuccess());
      } else {
        await PremiumController.instance.disablePremium();
        emit(PurchasesError());
      }
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
