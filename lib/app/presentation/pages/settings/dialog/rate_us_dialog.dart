import 'package:flutter/cupertino.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/rate_us/rate_us_cubit.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;
import 'package:rune_of_the_day/app/localization/language/languages.dart';

class RateApp {
  static var iosId = 'id1558378053';
  static var androidId = '';

  static void showYesNoDialog(BuildContext context) {
    Languages language = globals.Globals.instance.getLanguage();
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: new Text(language.runeOfTheDay),
        content: new Text(language.doYouEnjoyTheApp),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop('Discard');
              showRateUsDialog(context);
            },
            child: Text(language.yes),
          ),
          CupertinoDialogAction(
            onPressed: () {
              ///Never show the dialog again
              context.read<RateUsCubit>().emitDoNotShowAgain();
              Navigator.of(context, rootNavigator: true).pop('Discard');
            },
            child: Text(language.no),
          )
        ],
      ),
    );
  }

  static void showRateUsDialog(BuildContext context) {
    Languages language = globals.Globals.instance.getLanguage();
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: new Text(language.rateUsHeader),
        content: new Text(language.rateUsContent),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () async {
              await openRateUsPage(context);
              Navigator.of(context, rootNavigator: true).pop("Discard");
            },
            child: Text(language.rateNow),
          ),
          CupertinoDialogAction(
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop("Discard");
            },
            child: Text(language.rateLater),
          ),
          CupertinoDialogAction(
            onPressed: () {
              ///Never show the dialog again
              Navigator.of(context, rootNavigator: true).pop("Discard");
              context.read<RateUsCubit>().emitDoNotShowAgain();
            },
            child: Text(language.doNotRate),
          )
        ],
      ),
    );
  }

  static Future openRateUsPage(BuildContext context) async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      inAppReview.openStoreListing(appStoreId: iosId);

      ///test in app review after apk is in place
      // inAppReview.requestReview();
    }
    context.read<RateUsCubit>().emitDoNotShowAgain();
  }
}
