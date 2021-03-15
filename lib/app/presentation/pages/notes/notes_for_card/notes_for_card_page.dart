import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rune_of_the_day/app/business_logic/blocs/main_page_bloc.dart';
import 'package:rune_of_the_day/app/business_logic/change_notifiers/notes_change_model.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/journal_cubit/journal_cubit.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;
import 'package:rune_of_the_day/app/constants/styles/colours.dart';
import 'package:rune_of_the_day/app/constants/styles/constants.dart';
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';
import 'package:rune_of_the_day/app/data/models/card.dart';
import 'package:rune_of_the_day/app/data/models/note.dart';
import 'package:rune_of_the_day/app/data/repositories/floor_database.dart';
import 'package:rune_of_the_day/app/localization/language/languages.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_app_bar.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_card.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_future_builder.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_scuffold.dart';
import 'package:rune_of_the_day/app/presentation/pages/notes/common/card_image_widget.dart';
import 'package:rune_of_the_day/app/presentation/pages/pay_wall/navigate_to_premium.dart';
import 'package:rune_of_the_day/app/services/date_serivce.dart';
import 'package:rune_of_the_day/app/services/premium/premium_controller.dart';

import '../add/add_note_page.dart';
import '../edit/edit_note_page.dart';
import '../edit/edit_widget.dart';

class NotesForCardPage extends StatefulWidget {
  const NotesForCardPage({Key key, @required this.card, @required this.bloc})
      : super(key: key);

  final TarotCard card;
  final MainPageBloc bloc;

  static Widget create({BuildContext context, TarotCard card}) {
    return Consumer<MainPageBloc>(
      builder: (_, bloc, __) => NotesForCardPage(bloc: bloc, card: card),
    );
  }

  @override
  _NotesForCardPageState createState() => _NotesForCardPageState();
}

class _NotesForCardPageState extends State<NotesForCardPage> {
  TarotCard get card => widget.card;

  Languages get language => globals.Globals.instance.getLanguage();

  @override
  Widget build(BuildContext context) {
    return buildCustomFuture<List<Note>>(
      futureMethod: AppDatabase.getNotesForCard(card.id),
      builder: _buildContent,
    );
  }

  Widget _buildContent(List<Note> notes) {
    return CustomScaffold.withFab(
      appBar: CustomAppBar(
        children: _buildAppBarContent(),
      ),
      content: _buildScrollViewContent(notes),
      fab: _buildFab(context),
    );
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        var isPremium = await PremiumController.instance.isPremium();
        if (isPremium) {
          _navigateToAddNote(context);
        } else {
          navigatePremium(context);
        }
      },
      child: Icon(Icons.add),
      backgroundColor: fabActiveColor,
    );
  }

  void _navigateToEditNote(BuildContext value, Note note, String cardName) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<EditNotePage>(
          builder: (_) => MultiProvider(
                providers: [
                  Provider.value(value: Provider.of<MainPageBloc>(context)),
                  ChangeNotifierProvider.value(
                      value: Provider.of<NotesChangeModel>(context)),
                ],
                child: EditNotePage.create(
                  cardName: cardName,
                  context: context,
                  cardImage: note.cardImage,
                  note: note,
                ),
              )),
    );
  }

  void _navigateToAddNote(BuildContext value) {
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

  List<Widget> _buildAppBarContent() {
    return [
      Text(
        language.notesForCard,
        style: headerTextStyle,
      ),
    ];
  }

  Widget _buildScrollViewContent(List<Note> notes) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          _buildCardImage(),
          _buildList(notes),
          _buildBottomPaddingItem(),
        ],
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

  Widget _buildList(List<Note> notes) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        Note note = notes[index];
        return CustomCard(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 64.0),
            child: Column(
              children: [
                _buildNoteHeader(note),
                _buildNoteContent(note),
              ],
            ),
          ),
        );
      },
      childCount: notes.length,
      addAutomaticKeepAlives: false,
    ));
  }

  Widget _buildNoteContent(Note note) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12.0,
        bottom: 4,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                note.note,
                style: noteInputTextStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteHeader(Note note) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12.0,
        bottom: 4,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                DateService.toPresentationDate(note.date),
                style: noteInputHeaderTextStyle,
              ),
            ),
            Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buildEdit(
                    context,
                    note,
                    card.name,
                    _navigateToEditNote,
                  ),
                  buildDelete(note),
                ]),
          ],
        ),
      ),
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
        title: new Text(language.deleteNoteDialogHeader),
        content: new Text(language.deleteNoteDialogContent),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () async {
              await AppDatabase.deleteNote(note);
              Navigator.of(context, rootNavigator: true).pop('Discard');
              context.read<JournalCubit>().emitJournalByDates();
              context.read<JournalCubit>().emitJournalByCards();
              setState(() {
                widget.bloc.onDeleteNote();
              });
            },
            isDefaultAction: true,
            child: Text(language.yes),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(language.cancel),
          )
        ],
      ),
    );
  }

  Widget _buildCardImage() {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          CardImageWidget(
            imagePath: card.image,
            imageSizeRatio: 0.15,
          ),
          Text(
            removePrefix(card.name),
            style: notesForCardStyle,
          )
        ],
      ),
    );
  }

  String removePrefix(String str){
    var prefix1 = 'Перёвернутая';
    var prefix2 = 'Reversed';
    if(str.contains(prefix1) || str.contains(prefix2)){
      var stringList = str.split(' ');
      stringList.removeLast();
      return stringList.join(' ');
    }
    return str;
  }
}
