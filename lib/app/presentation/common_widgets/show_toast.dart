import 'package:fluttertoast/fluttertoast.dart';
import 'package:rune_of_the_day/app/constants/styles/colours.dart';

void showToast(String text) {
  Fluttertoast.showToast(
    fontSize: 18,
    backgroundColor: tabBackgroundColor,
    textColor: tabTextColor,
    msg: text,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_SHORT,
  );
}