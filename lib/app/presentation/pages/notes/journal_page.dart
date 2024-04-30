import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rune_of_the_day/app/business_logic/blocs/main_page_bloc.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/journal_cubit/journal_cubit.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/language_cubit/language_cubit.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;
import 'package:rune_of_the_day/app/constants/styles/colours.dart';
import 'package:rune_of_the_day/app/constants/styles/constants.dart';
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';
import 'package:rune_of_the_day/app/data/models/card.dart';
import 'package:rune_of_the_day/app/data/models/deck.dart';
import 'package:rune_of_the_day/app/data/models/note.dart';
import 'package:rune_of_the_day/app/data/repositories/floor_database.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_app_bar.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_card.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_scuffold.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/error_dialog.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/progress_bar.dart';
import 'package:rune_of_the_day/app/services/date_serivce.dart';

import 'common/card_image_widget.dart';
import 'edit/edit_note_page.dart';
import 'edit/edit_widget.dart';
import 'notes_for_card/notes_for_card_page.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({Key? key, this.bloc}) : super(key: key);
  final MainPageBloc? bloc;

  static Widget create(BuildContext context) {
    return Consumer<MainPageBloc>(
      builder: (_, bloc, __) => JournalPage(bloc: bloc),
    );
  }

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LanguageCubit, LanguageState>(
      ///rebuild page on language change
      listener: (context, state) {
        context.read<JournalCubit>().emitJournalByDates();
        context.read<JournalCubit>().emitJournalByCards();
      },
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    return BlocBuilder<JournalCubit, JournalState>(builder: (context, state) {
      if (state is JournalByDates) {
        return CustomScaffold.withFab(
          appBar: CustomAppBar(
            children: _buildAppBarContent(
                globals.Globals.instance.getLanguage().notesByDate),
          ),
          content: _buildNotesByCard(state.notesByDateToCards),
          fab: _buildFabs(fabActiveColor, fabInactiveColor),
        );
      } else if (state is JournalByCards) {
        return CustomScaffold.withFab(
          appBar: CustomAppBar(
            children: _buildAppBarContent(
                globals.Globals.instance.getLanguage().notesByRune),
          ),
          content: _buildNotesByCards(state.cardToNumNotes),
          fab: _buildFabs(fabInactiveColor, fabActiveColor),
        );
      } else if (state is JournalError) {
        return errorDialog();
      }
      return progressBar();
    });
  }

  Widget _buildNotesByCards(Map<TarotCard, int> cardToNumNotes) {
    return _buildScrollViewContentByCard(cardToNumNotes);
  }

  Widget _buildFabs(Color calendarFabColor, Color cardFabColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: fabSize,
            width: fabSize,
            child: FittedBox(
              child: FloatingActionButton(
                heroTag: 'btn1',
                onPressed: () {
                  context.read<JournalCubit>().emitJournalByDates();
                },
                child: Icon(
                  Icons.today,
                  color: itemTapPressedColor,
                ),
                backgroundColor: calendarFabColor,
              ),
            ),
          ),
          Container(
            height: fabSize,
            width: fabSize,
            child: FittedBox(
              child: FloatingActionButton(
                heroTag: 'btn2',
                onPressed: () {
                  context.read<JournalCubit>().emitJournalByCards();
                },
                child: Icon(
                  Icons.stay_current_portrait_rounded,
                  color: itemTapPressedColor,
                ),
                backgroundColor: cardFabColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAppBarContent(String header) {
    return [
      Text(
        header,
        style: headerTextStyle,
      ),
    ];
  }

  Widget _buildScrollViewContentByCard(Map<TarotCard, int> cardToNumNotes) {
    if (cardToNumNotes.isEmpty) {
      return _showEmptyPageMessage();
    }
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: CustomScrollView(
          slivers: [
            _buildListByCard(cardToNumNotes),
            _buildBottomPaddingItem(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPaddingItem() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        height: 50.0,
      ),
    );
  }

  Widget _buildNotesByCard(Map<Note, TarotDeckCard> notesToCards) {
    if (notesToCards.isEmpty) {
      return _showEmptyPageMessage();
    }
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: CustomScrollView(
          slivers: [
            _buildList(notesToCards),
            _buildBottomPaddingItem(),
          ],
        ),
      ),
    );
  }

  Widget _showEmptyPageMessage() {
    var language = globals.Globals.instance.getLanguage();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: CustomCard(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    language.noNotesExist,
                    style: headerTextStyle,
                  ),
                  _buildLine(),
                  // _buildLine(this.context),
                  Text(
                    language.youCanAlwaysAddNodes,
                    style: contextTextStyle(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildLine() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: Container(
        height: 1.0,
        width: MediaQuery.of(context).size.width * 0.68,
        color: cardLineColor,
      ),
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

  Widget _buildListByCard(Map<TarotCard, int> cardsToNumNotes) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        var entryList = cardsToNumNotes.entries.toList();
        var cardToNotes = entryList[index];
        var card = cardToNotes.key;
        var numOfNotes = cardToNotes.value;
        return InkWell(
          onTap: () {
            _openNotesForCard(context, card);
          },
          child: CustomCard(
            child: Row(
              children: [
                _buildCardImage(card.image, false),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        card.name!,
                        style: noteInputHeaderTextStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          globals.Globals.instance.getLanguage().numberOfNotes +
                              numOfNotes.toString(),
                          style: noteInputTextStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      childCount: cardsToNumNotes.length,
      addAutomaticKeepAlives: false,
    ));
  }

  Widget _buildList(Map<Note, TarotDeckCard> notesToCards) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        var noteToCard = notesToCards.entries.toList()[index];
        var note = noteToCard.key;
        var isFlippedSuffix = note.isFlipped!
            ? globals.Globals.instance.getLanguage().isFlipped
            : '';
        var card = noteToCard.value;
        return CustomCard(
          child: Row(
            children: [
              _buildCardImage(note.cardImage, note.isFlipped!),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateService.toPresentationDate(note.date)!,
                            style: noteInputHeaderTextStyle,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                buildEdit(
                                  context,
                                  note,
                                  card.name! + isFlippedSuffix,
                                  _navigateToEditNote,
                                ),
                                buildDelete(note),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        card.name!,
                        // card.name,
                        style: noteInputTextStyle(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 12.0, right: 8.0),
                      child: Text(
                        note.note!,
                        style: noteInputTextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      childCount: notesToCards.entries.toList().length,
      addAutomaticKeepAlives: false,
    ));
  }

  void _navigateToEditNote(BuildContext value, Note note, String? cardName) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<EditNotePage>(
          builder: (_) => MultiProvider(
                providers: [
                  Provider.value(value: Provider.of<MainPageBloc>(context)),
                ],
                child: EditNotePage.create(
                  context: context,
                  cardName: cardName,
                  cardImage: note.cardImage,
                  note: note,
                ),
              )),
    );
  }

  Widget buildDelete(Note note) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(),
      icon: Icon(
        Icons.delete,
        size: editDeleteIconSize,
        color: cardHeaderColor,
      ),
      onPressed: () => _delete(note),
    );
  }

  Future<void> _delete(Note note) async {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: new Text(
            globals.Globals.instance.getLanguage().deleteNoteDialogHeader),
        content: new Text(
            globals.Globals.instance.getLanguage().deleteNoteDialogContent),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () async {
              await AppDatabase.deleteNote(note);
              Navigator.of(context, rootNavigator: true).pop('Discard');
              context.read<JournalCubit>().emitJournalByDates();
              widget.bloc!.onDeleteNote();
            },
            isDefaultAction: true,
            child: Text(globals.Globals.instance.getLanguage().yes),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(globals.Globals.instance.getLanguage().cancel),
          )
        ],
      ),
    );
  }

  Widget _buildCardImage(String? image, bool isFlipped) {
    if (isFlipped) {
      return new RotationTransition(
        turns: new AlwaysStoppedAnimation(180 / 360),
        child: CardImageWidget(
          imagePath: image,
          imageSizeRatio: 0.10,
        ),
      );
    }

    return CardImageWidget(
      imagePath: image,
      imageSizeRatio: 0.10,
    );
  }
}
