import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;
import 'package:rune_of_the_day/app/constants/styles/icons.dart';
import 'package:rune_of_the_day/app/data/models/card.dart';
import 'package:rune_of_the_day/app/data/models/note.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/card_category/castom_category_card.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_card.dart';
import 'package:rune_of_the_day/app/presentation/pages/notes/add/add_notes_widgets.dart';
import 'package:rune_of_the_day/app/services/date_serivce.dart';

Widget buildNotesCard({
  bool isVisible = true,
  required Note note,
  required TarotCard card,
  required BuildContext context,
}) {
  return _buildContent(
    isVisible: isVisible,
    note: note,
    card: card,
    cardId: card.id,
    context: context,
  );
}

SliverToBoxAdapter _buildContent({
  required bool isVisible,
  Note? note,
  BuildContext? context,
  TarotCard? card,
  ValueSetter<Note>? onAddNote,
  int? cardId,
}) {
  if (isVisible) {
    return SliverToBoxAdapter(
      child: CustomCard(
        child: Column(
          children: [
            _cardBase(context, getNoteContent(context, note!)),
            buildAddNotes(
              context: context,
              card: card,
              onAddNote: onAddNote,
              cardId: cardId,
            ),
          ],
        ),
      ),
    );
  }
  return SliverToBoxAdapter();
}

String getNoteContent(BuildContext? context, Note note) {
  if (note.note != null && note.note != '') {
    return globals.Globals.instance.getLanguage().lastNoteOn +
        DateService.toPresentationDate(note.date)! +
        ':' +
        '\n\n' +
        note.note!;
  }
  return '';
}

CustomCategoryCard _cardBase(BuildContext? context, String cardContent) {
  return CustomCategoryCard(
    header: globals.Globals.instance.getLanguage().notesHeader,
    content: cardContent,
    icon: noteIcon,
    isWrapped: false,
  );
}
