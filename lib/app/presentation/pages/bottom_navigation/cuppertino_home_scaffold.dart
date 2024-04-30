import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/language_cubit/language_cubit.dart';
import 'package:rune_of_the_day/app/constants/enums/enums.dart';
import 'package:rune_of_the_day/app/constants/styles/colours.dart';
import 'package:rune_of_the_day/app/presentation/pages/bottom_navigation/tab_item.dart';
import 'package:rune_of_the_day/app/services/ads/ad_service.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold({
    Key? key,
    required this.currentTab,
    required this.onSelectTab,
    required this.widgetBuilders,
    required this.navigatorKeys,
  }) : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(builder: (context, state) {
      return CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            border: Border(
              top: BorderSide(width: 0.0, color: bottomNavBarColor),
            ),
            activeColor: itemTapPressedColor,
            inactiveColor: itemTapDefaultColor,
            backgroundColor: bottomNavBarColor,
            items: [
              _buildItem(TabItem.home),
              _buildItem(TabItem.deck),
              _buildItem(TabItem.journal),
              _buildItem(TabItem.more),
            ],
            onTap: (index) async{
                await AdManager.showInterstitial();
                onSelectTab(TabItem.values[index]);
              },
          ),
          tabBuilder: (context, index) {
            final item = TabItem.values[index];
            return CupertinoTabView(
              navigatorKey: navigatorKeys[item],
              builder: (context) => widgetBuilders[item]!(context),
            );
          });
    });
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemDataMap().getAllTabs()[tabItem]!;
    return BottomNavigationBarItem(
      icon: Icon(
        itemData.icon,
      ),
      label: itemData.title,
    );
  }
}
