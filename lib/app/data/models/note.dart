import 'package:floor/floor.dart';
import 'package:rune_of_the_day/app/constants/styles/constants.dart';

@Entity(tableName: noteTable)
class Note {
  @PrimaryKey(autoGenerate: true)
  final int noteId;

  final int cardId;
  final String cardImage;
  final String date;
  final String note;
  final int timeSaved;
  final bool isFlipped;

  const Note({
    this.noteId,
    this.cardId,
    this.cardImage = '',
    this.date = '',
    this.note = '',
    this.timeSaved,
    this.isFlipped = false,
  });
}
