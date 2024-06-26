import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_funding_choices/flutter_funding_choices.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/other_app_cubit/OtherAppCubit.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/purchases/purchases_cubit.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
as globals;
import 'package:rune_of_the_day/app/constants/strings/strings.dart';
import 'package:rune_of_the_day/app/constants/styles/colours.dart';
import 'package:rune_of_the_day/app/constants/styles/constants.dart';
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';
import 'package:rune_of_the_day/app/localization/language/language_ru.dart';
import 'package:rune_of_the_day/app/localization/language/languages.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/ad_widget.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_app_bar.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_card.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_scuffold.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/error_dialog.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/show_toast.dart';
import 'package:rune_of_the_day/app/presentation/pages/attribution/attribution_page.dart';
import 'package:rune_of_the_day/app/presentation/pages/pay_wall/pay_wall.dart';
import 'package:rune_of_the_day/app/presentation/pages/settings/dialog/landuages_dialog.dart';
import 'package:rune_of_the_day/app/presentation/pages/settings/dialog/notification_dialog.dart';
import 'package:rune_of_the_day/app/presentation/pages/settings/dialog/text_size_dialog.dart';
import 'package:rune_of_the_day/app/services/premium/premium_controller.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dialog/rate_us_dialog.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: CustomAppBar(
          children: _buildAppBarContent(context),
        ),
        content: _buildContent(context));
  }

  List<Widget> _buildAppBarContent(BuildContext context) {
    return [
      Text(
        globals.Globals.instance
            .getLanguage()
            .settings,
        style: headerTextStyle,
      ),
    ];
  }

  Widget _buildContent(BuildContext context) {
    return BlocListener<PurchasesCubit, PurchasesState>(
        listener: (context, state) {
          if (state is PurchasesRestored) {
            showToast(globals.Globals.instance
                .getLanguage()
                .purchaseRestored);
          }
        },
        child: CustomScrollView(
          slivers: [buildRecord(context)],
        ));
  }

  Widget buildRecord(BuildContext context) {
    var language = globals.Globals.instance.getLanguage();
    return SliverToBoxAdapter(
        child: SafeArea(
          child: Column(
            children: [
              _buildFirstSetting1(language, context),
              _buildMoreApps(context),
              _buildFirstSetting2(language, context),
            ],
          ),
        ));
  }

  Widget _buildMoreApps(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  globals.Globals.instance
                      .getLanguage()
                      .moreApps,
                  style: moreAppsHeaderTextStyle,
                ),
              ),
            ),
          ),
        ),
        _getMoreApps(context)
      ],
    );
  }

  Widget _getMoreApps(BuildContext context) {
    OtherAppCubit otherAppCubit = OtherAppCubit();
    otherAppCubit.loadOtherApps(context);

    return CustomCard(
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: BlocBuilder<OtherAppCubit, OtherAppsState>(
              bloc: otherAppCubit,
              builder: (context, state) {
                if (state is OtherAppsLoading) {
                  return Container();
                } else if (state is OtherAppsLoaded) {
                  return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: state.otherApps
                          .map((e) =>
                          GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(18.0),
                                      child: CachedNetworkImage(
                                          fadeInDuration: Duration.zero,
                                          fadeOutDuration: Duration.zero,
                                          height: 66,
                                          width: 66,
                                          imageUrl: e.imageLink!,
                                          fit: BoxFit.cover),
                                    ),
                                    appAdWidgetTag()
                                  ],
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    child: SizedBox(
                                        width: 90,
                                        child: Text(
                                          e.name!, style: moreAppsTextStyle,
                                          textAlign: TextAlign.center,)))
                              ]),
                            ),
                            onTap: () {
                              launchUrl(Uri.parse(e.link!),
                                  mode: LaunchMode.externalApplication);
                            },
                          ))
                          .toList());
                } else {
                  return errorDialog();
                }
              })),
    );
  }

  Padding _buildFirstSetting1(Languages language, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
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
                _buildSetting(Icons.language, language.language, context,
                        () => _showLanguageDialog(context)),
                _buildLine(context),
                _buildSetting(Icons.notifications_none, language.notifications,
                    context, () => _showNotificationDialog(context)),
                _buildLine(context),
                _buildSetting(Icons.email_outlined, language.contactUs,
                  context, () => _openCommunication(),
                ),
                _buildLine(context),
                _buildSetting(Icons.format_size, language.textSize, context,
                        () => _showTextSizeDialog(context)),
                _buildLine(context),
                _buildSetting(Icons.restore, language.restorePurchase, context,
                        () => _restorePurchase(context)),
                _buildPremium(language, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPremium(Languages language, BuildContext context) {
    return FutureBuilder<bool>(
        future: PremiumController.instance.isPremium(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                var isPremium = snapshot.data!;
                if (isPremium) {
                  return Container();
                } else {
                  return Column(
                    children: [
                      _buildLine(context),
                      _buildSetting(
                        Icons.stars,
                        language.goPremium,
                        context,
                            () => _goToPremium(context),
                      ),
                    ],
                  );
                }
              }
          }
        });
  }

  Padding _buildFirstSetting2(Languages language, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
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
                _buildSetting(
                  Icons.star,
                  language.rateUsHeader,
                  context,
                      () => RateApp.openRateUsPage(context),
                ),
                _buildLine(context),
                _buildTelegramLink(context),
                _buildWebsiteLink(context),
                _buildSetting(
                  Icons.share,
                  language.shareApp,
                  context,
                      () => _shareApp(context),
                ),
                _buildLine(context),
                _buildSetting(
                  Icons.list_alt,
                  language.privacyPolicy,
                  context,
                      () => _openLink(privacyPolicyURL),
                ),
                _buildLine(context),
                _buildSetting(Icons.info_outline, language.info, context,
                        () => _goToAttribution(context)),
                _buildConsent(context, language),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConsent(BuildContext context, Languages language) {
    return FutureBuilder<bool>(
        future: _shouldShowConsent(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return errorDialog();
              } else {
                var shodShowConsent = snapshot.data!;
                if (!shodShowConsent) {
                  return Container();
                }
                return Column(
                  children: [
                    _buildLine(context),
                    _buildSetting(
                      Icons.article,
                      language.consent,
                      context,
                          () => _showConsent(),
                    ),
                  ],
                );
              }
          }
        });
  }

  Future<void> _restorePurchase(BuildContext context) async {
    await context.read<PurchasesCubit>().restorePurchases();
  }

  Widget _buildTelegramLink(BuildContext context) {
    if (globals.Globals.instance.getLanguage() is LanguageRu) {
      return Column(
        children: [
          _buildSetting(
            Icons.send,
            telegram,
            context,
                () => _openLink(telegramURL),
          ),
          _buildLine(context),
        ],
      );
    }
    return Container();
  }

  void _openCommunication() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: {
    'subject': emailSubject + '_' + 'version:' + packageInfo.version+'_'+'build:'+packageInfo.buildNumber
    }
    );
    await launchUrl(Uri.parse(emailLaunchUri.toString()));
  }

  Widget _buildWebsiteLink(BuildContext context) {
    if (globals.Globals.instance.getLanguage() is LanguageRu) {
      return Column(
        children: [
          _buildSetting(
            Icons.web,
            ourWebsite,
            context,
                () => _openLink(websiteURL),
          ),
          _buildLine(context),
        ],
      );
    }
    return Container();
  }

  Future<bool> _shouldShowConsent() async {
    ConsentInformation consentInfo =
    await FlutterFundingChoices.requestConsentInformation();
    if (consentInfo.isConsentFormAvailable &&
        consentInfo.consentStatus == ConsentStatus.OBTAINED) {
      return true;
    }
    return false;
  }

  Future<void> _showConsent() async {
    await FlutterFundingChoices.showConsentForm();
  }

  void _openLink(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: somethingWentWrong,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  void _goToPremium(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(builder: (_) {
      return PayWall();
    }));
  }

  void _goToAttribution(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(builder: (_) {
      return AttributionPage();
    }));
  }

  void _shareApp(BuildContext context) {
    final String url = linkToApp;
    final RenderBox box = context.findRenderObject() as RenderBox;
    Share.share(url,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  Widget _buildSetting(IconData icon, String text, BuildContext context,
      Function onClick) {
    var customIcon = Icon(
      icon,
      color: settingsIconColor,
    );
    return _buildSettingWithIcon(onClick, customIcon, text);
  }

  Widget _buildSettingWithIcon(Function onClick, Widget icon, String text) {
    return TextButton(
      onPressed: () {
        onClick();
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: icon,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            child: Text(
              text,
              style: settingsTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  void _showNotificationDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => NotificationDialog(),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showCupertinoModalPopup(
        context: context, builder: (context) => LanguageDialog());
  }

  void _showTextSizeDialog(BuildContext context) {
    showCupertinoCustomDialog(context);

    /// platform dependent dialog usage example
    // if (Platform.isIOS) {
    //   showCupertinoDialog(context);
    // } else {
    //   showMaterialDialog(context);
    // }
  }

  void showMaterialDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => TextSizeDialog());
  }

  void showCupertinoCustomDialog(BuildContext context) {
    showCupertinoModalPopup(
        context: context, builder: (context) => TextSizeDialog());
  }

  Padding _buildLine(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 0.0),
      child: Container(
        height: 1.0,
        width: MediaQuery
            .of(context)
            .size
            .width * 0.68,
        color: cardLineColor,
      ),
    );
  }
}
