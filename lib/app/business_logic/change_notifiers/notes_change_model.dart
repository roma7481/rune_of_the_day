import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/constants/enums/enums.dart';

class NotesChangeModel with ChangeNotifier {
  NotesChangeModel({
    NoteState noteState = NoteState.notUpdated,
  });

  NoteState notesState;

  void updateNotes() {
    updateWith(notesState: NoteState.updated);
    notesState = NoteState.notUpdated; //reset the state
  }

  void updateWith({
    NoteState notesState,
  }) {
    this.notesState = notesState ?? this.notesState;
    notifyListeners();
  }
}
