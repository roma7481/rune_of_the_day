import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;
import 'package:rune_of_the_day/app/constants/styles/icons.dart';
import 'package:rune_of_the_day/app/data/models/card.dart';
import 'package:rune_of_the_day/app/data/models/category.dart';
import 'package:rune_of_the_day/app/localization/language/languages.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/share_widgets.dart';
import 'package:rune_of_the_day/app/presentation/pages/card_description/detailed_description_args.dart';
import 'package:rune_of_the_day/app/presentation/pages/card_description/detailed_description_page.dart';
import 'package:rune_of_the_day/app/services/ads/ad_counter.dart';
import 'package:rune_of_the_day/app/services/ads/ad_service.dart';
import 'package:rune_of_the_day/app/services/ads/interestitial_controller.dart';
import 'package:rune_of_the_day/app/services/ads/native_admob.dart';
import 'package:rune_of_the_day/app/services/ads/native_admob_controller.dart';
import 'package:rune_of_the_day/app/services/premium/premium_controller.dart';

import '../custom_card.dart';
import '../error_dialog.dart';
import 'castom_category_card.dart';

class ListTileBuilder extends StatelessWidget {
  ListTileBuilder({@required this.card, @required this.isSelectNewCard});

  final TarotCard card;
  final bool isSelectNewCard;
  static const _adUnitID = realNativeAppId;
  final _nativeAdController = NativeAdmobController();

  @override
  Widget build(BuildContext context) {
    return (isSelectNewCard) ? _buildSelectNewCardTile() : _buildList();
  }

  Widget _buildList() {
    return FutureBuilder<bool>(
        future: PremiumController.instance.isPremium(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return SliverToBoxAdapter(
                child: Container(),
              );
            default:
              if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: errorDialog(),
                );
              } else {
                var isPremium = snapshot.data;
                return _buildListTile(isPremium);
              }
          }
        });
  }

  SliverToBoxAdapter _buildSelectNewCardTile() {
    Languages language = globals.Globals.instance.getLanguage();
    return SliverToBoxAdapter(
      child: CustomCard(
        child: CustomCategoryCard(
          header: language.runeOfTheDay,
          content: language.selectRune,
          icon: starIcon,
          isDefaultCard: true,
        ),
      ),
    );
  }

  Widget _buildListTile(bool isPremium) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        CardCategory category = card.categories[index];
        if (isPremium) {
          return Column(children: [
            _buildItem(category, context),
          ]);
        }
        return Column(children: [
          _adItem(index),
          _buildItem(category, context),
        ]);
      },
      childCount: card.categories.length,
    ));
  }

  CustomCard _buildItem(CardCategory category, BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          CustomCategoryCard(
            header: category.header,
            content: category.description,
            icon: category.icon,
            onMoreInfoPressed: () => _onMoreInfoPressed(
              context,
              card.name,
              Image.asset(card.image),
              category,
            ),
          ),
          buildShareAndCopy(category.description, context),
        ],
      ),
    );
  }

  Widget _adItem(int listItemIndex) {
    if (listItemIndex == 0 || listItemIndex == 3) {
      return NativeAdmob(
        // Your ad unit id
        error: Visibility(
          child: Container(),
          maintainSize: false,
          visible: false,
        ),
        adUnitID: _adUnitID,
        numberAds: 2,
        controller: _nativeAdController,
        type: NativeAdmobType.full,
      );
    }
    return Container();
  }

  void _onMoreInfoPressed(
    BuildContext context,
    String header,
    Widget image,
    CardCategory category,
  ) async {
    Widget descriptionCard = SliverToBoxAdapter(
      child: CustomCard(
        child: CustomCategoryCard(
          header: category.header,
          content: category.description,
          icon: category.icon,
          isWrapped: false,
          isDefaultCard: false,
        ),
      ),
    );

    await AdsCounter.instance.increaseAdCounter();
    var adController = InterestitialController.instance;

    adController.setCallback(() => _navigateToDetailedDescription(
          context,
          image,
          header,
          descriptionCard,
        ));

    await adController.showInterstitialAd();
  }

  void _navigateToDetailedDescription(BuildContext context, Widget image,
      String header, Widget descriptionCard) {
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (context) => DetailedDescriptionPage(
              args: DetailedDescriptionArgs(
                image: image,
                headerText: header,
                descriptionCard: descriptionCard,
              ),
            )));
  }
}
