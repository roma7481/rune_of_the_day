import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;
import 'package:rune_of_the_day/app/constants/strings/strings.dart';
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_app_bar.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_card.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_scuffold.dart';
import 'package:url_launcher/url_launcher.dart';

class AttributionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: CustomAppBar(
          children: [_buildAppBarContent()],
        ),
        content: _buildContent(context));
  }

  Widget _buildAppBarContent() {
    return Text(
      globals.Globals.instance.getLanguage().info,
      style: headerTextStyle,
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Align(
          //To make container wrap parent you can wrap it in align
          alignment: Alignment.topCenter,
          child: CustomCard(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, right: 12.0, top: 16.0, bottom: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildContentRow('https://www.flaticon.com/'),
                  _buildContentRow('https://www.predskazanie.ru'),
                  _buildContentRow('https://www.freepik.com'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentRow(String url) {
    return Align(
      alignment: Alignment.topLeft,
      child: InkWell(
        onTap: () async {
          try {
            if (await canLaunch(url)) {
              await launch(url);
            }
          } catch (e) {
            Fluttertoast.showToast(
              msg: somethingWentWrong,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_SHORT,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
          child: Text(
            url,
            style: urlLinkStyle,
          ),
        ),
      ),
    );
  }
}
