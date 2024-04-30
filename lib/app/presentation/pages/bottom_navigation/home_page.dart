import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/rate_us/rate_us_cubit.dart';
import 'package:rune_of_the_day/app/constants/enums/enums.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/progress_bar.dart';
import 'package:rune_of_the_day/app/presentation/pages/deck/tarot_deck_page.dart';
import 'package:rune_of_the_day/app/presentation/pages/notes/journal_page.dart';
import 'package:rune_of_the_day/app/presentation/pages/pay_wall/pay_wall.dart';
import 'package:rune_of_the_day/app/presentation/pages/settings/dialog/rate_us_dialog.dart';
import 'package:rune_of_the_day/app/presentation/pages/settings/settings_page.dart';
import 'package:rune_of_the_day/app/services/premium/premium_controller.dart';

import '../main/main_page_bloc_based.dart';
import 'cuppertino_home_scaffold.dart';
import 'language_dialog_on_start.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.home;

  @override
  void initState() {
    super.initState();
  }

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.deck: GlobalKey<NavigatorState>(),
    TabItem.journal: GlobalKey<NavigatorState>(),
    TabItem.more: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.home: (_) => MainPageBlocBased.create(context),
      TabItem.deck: (_) => TarotDeckPage(),
      TabItem.journal: (_) => _getJournalPage(),
      TabItem.more: (_) => SettingsPage(),
    };
  }

  Widget _getJournalPage() {
    return FutureBuilder<bool>(
        future: PremiumController.instance.isPremium(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return progressBar();
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                var isPremium = snapshot.data!;
                if (isPremium) {
                  return JournalPage.create(context);
                } else {
                  return PayWall();
                }
              }
          }
        });
  }

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    }
    setState(() => _currentTab = tabItem);
  }

  @override
  Widget build(BuildContext context) {

    displayLanguageDialog(context);
    return BlocListener<RateUsCubit, RateUsState>(
      listener: (context, state) {
        if (state.shouldShowDialog!) {
          RateApp.showYesNoDialog(context);
          context.read<RateUsCubit>().emitStopShowing();
        }
      },
      child: WillPopScope(
        onWillPop: () async =>
            !await navigatorKeys[_currentTab]!.currentState!.maybePop(),
        child: CupertinoHomeScaffold(
          currentTab: _currentTab,
          onSelectTab: _select,
          widgetBuilders: widgetBuilders,
          navigatorKeys: navigatorKeys,
        ),
      ),
    );
  }
}
