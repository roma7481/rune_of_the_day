import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/constants/styles/colours.dart';
import 'package:rune_of_the_day/app/constants/styles/constants.dart';
import 'package:rune_of_the_day/app/data/models/note.dart';

Widget buildEdit(
  BuildContext context,
  Note note,
  String? cardName,
  Function(BuildContext, Note, String?) onEdit,
) {
  return IconButton(
      padding: EdgeInsets.all(16.0),
      constraints: BoxConstraints(),
      icon: Icon(
        Icons.edit,
        size: editDeleteIconSize,
        color: cardHeaderColor,
      ),
      onPressed: () => onEdit(context, note, cardName));
}
