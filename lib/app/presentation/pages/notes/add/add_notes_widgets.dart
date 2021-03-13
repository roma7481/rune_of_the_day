import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rune_of_the_day/app/business_logic/blocs/main_page_bloc.dart';
import 'package:rune_of_the_day/app/business_logic/change_notifiers/notes_change_model.dart';
import 'package:rune_of_the_day/app/constants/styles/constants.dart';
import 'package:rune_of_the_day/app/constants/styles/icons.dart';
import 'package:rune_of_the_day/app/data/models/card.dart';
import 'package:rune_of_the_day/app/data/models/note.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/csv_icon_widget.dart';
import 'package:rune_of_the_day/app/presentation/pages/notes/notes_for_card/notes_for_card_page.dart';
import 'package:rune_of_the_day/app/presentation/pages/pay_wall/navigate_to_premium.dart';
import 'package:rune_of_the_day/app/services/premium/premium_controller.dart';

import 'add_note_page.dart';

Widget buildAddNotes({
  @required BuildContext context,
  @required TarotCard card,
  @required ValueSetter<Note> onAddNote,
  @required int cardId,
}) {
  return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
    IconButton(
        icon: buildIcon(plusIcon, notesIconSize),
        onPressed: () async {
          var isPremium = await PremiumController.instance.isPremium();
          if (isPremium) {
            _openAddNote(context, card, onAddNote, cardId);
          } else {
            navigatePremium(context);
          }
        }),
    IconButton(
        icon: buildIcon(journalIcon, notesIconSize),
        onPressed: () async {
          var isPremium = await PremiumController.instance.isPremium();
          if (isPremium) {
            _openNotesForCard(context, card);
          } else {
            navigatePremium(context);
          }
        })
  ]);
}

void _openAddNote(
  BuildContext context,
  TarotCard card,
  ValueSetter<Note> onAddNote,
  int cardId,
) {
  Navigator.of(context, rootNavigator: true).push(
    MaterialPageRoute<AddNotePage>(
        builder: (_) => MultiProvider(
              providers: [
                Provider.value(value: Provider.of<MainPageBloc>(context)),
                ChangeNotifierProvider.value(
                    value: Provider.of<NotesChangeModel>(context)),
              ],
              child: AddNotePage.create(context: context, card: card),
            )),
  );
}

void _openNotesForCard(BuildContext context, TarotCard card) {
  Navigator.of(context, rootNavigator: true).push(
    MaterialPageRoute<NotesForCardPage>(
      builder: (_) => Provider.value(
        value: Provider.of<MainPageBloc>(context),
        child: NotesForCardPage.create(context: context, card: card),
      ),
    ),
  );
}
