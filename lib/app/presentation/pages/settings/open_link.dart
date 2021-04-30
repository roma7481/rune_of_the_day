import 'package:fluttertoast/fluttertoast.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart';
import 'package:url_launcher/url_launcher.dart';

void openLink(String url) async {
  try {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    }
  } catch (e) {
    Fluttertoast.showToast(
      msg: Globals.instance.language.errorMessageContent,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
