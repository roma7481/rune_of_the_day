import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/purchases/purchases_cubit.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart';
import 'package:rune_of_the_day/app/constants/styles/colours.dart';
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';
import 'package:rune_of_the_day/app/localization/language/languages.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_app_bar.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_card.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_scuffold.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/error_dialog.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/progress_bar.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/show_toast.dart';

class PayWall extends StatefulWidget {
  @override
  _PayWallState createState() => _PayWallState();
}

class _PayWallState extends State<PayWall> {
  void _onPurchaseError() {
    showToast(globals.Globals.instance.getLanguage().purchaseError);
  }

  void _onSuccess() {
    showToast(globals.Globals.instance.getLanguage().purchaseSuccess);
  }

  void _onCanceled() {
    showToast(globals.Globals.instance.getLanguage().purchaseCanceled);
  }

  void _onRestored (){
    showToast(globals.Globals.instance.getLanguage().purchaseRestored);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PurchasesCubit, PurchasesState>(
        listener: (BuildContext context, state) {
          if (state is PurchasesCanceled) {
            _onCanceled();
          } else if(state is PurchasesSuccess){
            _onSuccess();
          }  else if(state is PurchasesRestored){
            _onRestored();
          } else if(state is PurchasesError){
            _onPurchaseError();
          } else if(state is PurchasesInitFailed){
            context.read<PurchasesCubit>().emitInitPurchases();
          }
        },
        builder: (context, state) {
          if (state is PurchasesInitFailed) {
            return errorDialog();
          } else if (state is PurchasesLoading) {
            return progressBar();
          }
          return _buildPageContent(context);
        });
  }

  CustomScaffold _buildPageContent(BuildContext context) {
    return CustomScaffold(
        appBar: CustomAppBar(
          children: [_buildAppBarContent()],
        ),
        content: _buildContent(context));
  }

  Widget _buildAppBarContent() {
    return Text(
      globals.Globals.instance.getLanguage().premium,
      style: headerTextStyle,
    );
  }

  Widget _buildContent(BuildContext context) {
    var language = globals.Globals.instance.getLanguage();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Align(
          //To make container wrap parent you can wrap it in align
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              buildSupportUsMessage(),
              pageContent(language, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSupportUsMessage() {
    return CustomCard(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            Globals.instance.getLanguage().supportUs,
            textAlign: TextAlign.center,
            style: supportUsTextStyle(),
          ),
        ));
  }

  CustomCard pageContent(Languages language, BuildContext context) {
    return CustomCard(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 12.0, top: 16.0, bottom: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildContentRow(language.goPremium, Icons.stars),
                _buildLine(context),
                _buildContentRow(
                    language.runeJournalAndNotes, Icons.check_circle),
                _buildContentRow(language.removeAds, Icons.check_circle),
                _buildContentRow(
                    language.oneTimePayment, Icons.monetization_on_outlined),
                _buildBuyButton()
              ],
            ),
          ),
        );
  }

  Widget _buildBuyButton() {
    String price = context.read<PurchasesCubit>().price;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Builder(
        builder: (buttonContext) => InkWell(
            onTap: () => _onClick(buttonContext),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SizedBox(
                child: Container(
                  color: buttonColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      globals.Globals.instance.getLanguage().buy + ' ' + price,
                      style: buttonTextStyle(),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Widget _buildContentRow(String text, IconData icon) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20.0),
          child: Icon(
            icon,
            color: settingsIconColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20.0),
          child: Text(text, style: settingsTextStyle),
        ),
      ],
    );
  }

  Padding _buildLine(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: Container(
        height: 1.0,
        width: MediaQuery.of(context).size.width * 0.68,
        color: cardLineColor,
      ),
    );
  }

  Future<void> _onClick(BuildContext context) async {
    await context.read<PurchasesCubit>().emitBuyProduct();
  }
}
