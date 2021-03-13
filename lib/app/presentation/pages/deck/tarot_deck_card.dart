import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/constants/styles/colours.dart';
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';
import 'package:rune_of_the_day/app/data/models/deck.dart';
import 'package:rune_of_the_day/app/services/ads/ad_counter.dart';
import 'package:rune_of_the_day/app/services/ads/interestitial_controller.dart';

import 'deck_card_descr_page.dart';

class TarotDeckCardWidget extends StatelessWidget {
  TarotDeckCardWidget({@required this.card});

  final TarotDeckCard card;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          color: deckCardColor.withOpacity(0.8),
          child: Column(
            children: [
              Expanded(
                // Should wrap the padding into Expandable to avoid pixels overflow
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: card.image,
                    iconSize: MediaQuery.of(context).size.height * 0.20,
                    onPressed: () async {
                      await AdsCounter.instance.increaseAdCounter();
                      var adController = InterestitialController.instance;

                      adController.setCallback(
                          () => _navigateToRoute(context, card.cardId));

                      await adController.showInterstitialAd();
                    },
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    card.name,
                    textAlign: TextAlign.center,
                    style: cardDeckTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToRoute(BuildContext context, int cardId) {
    Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(
      builder: (BuildContext context) {
        return new TarotDeckCardDescription(
          cardId: cardId,
        );
      },
    ));
  }
}
