import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;
import 'package:rune_of_the_day/app/constants/enums/enums.dart';

class TabItemData {
  TabItemData({@required this.title, @required this.icon});

  final String title;
  final IconData icon;
}

class TabItemDataMap {
  var language = globals.Globals.instance.getLanguage();

  Map<TabItem, TabItemData> getAllTabs() {
    return {
      TabItem.home: TabItemData(title: language.homeTabText, icon: Icons.home),
      TabItem.deck: TabItemData(title: language.deckTabText, icon: Icons.book),
      TabItem.journal: TabItemData(
          title: language.journalTabText, icon: Icons.view_headline),
      TabItem.more:
          TabItemData(title: language.moreTabText, icon: Icons.settings),
    };
  }
}
