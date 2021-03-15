import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rune_of_the_day/app/business_logic/blocs/main_page_bloc.dart';
import 'package:rune_of_the_day/app/business_logic/change_notifiers/notes_change_model.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/journal_cubit/journal_cubit.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;
import 'package:rune_of_the_day/app/constants/styles/colours.dart';
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';
import 'package:rune_of_the_day/app/data/models/card.dart';
import 'package:rune_of_the_day/app/data/models/note.dart';
import 'package:rune_of_the_day/app/data/repositories/floor_database.dart';
import 'package:rune_of_the_day/app/localization/language/languages.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_app_bar.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_scuffold.dart';
import 'package:rune_of_the_day/app/presentation/pages/notes/common/notes_header.dart';
import 'package:rune_of_the_day/app/services/date_serivce.dart';

import '../common/date_time_picker.dart';

class AddNotePage extends StatefulWidget {
  AddNotePage({
    Key key,
    @required this.card,
    @required this.bloc,
    @required this.notesChangeModel,
  }) : super(key: key);

  final TarotCard card;
  final MainPageBloc bloc;
  final NotesChangeModel notesChangeModel;

  static Widget create({BuildContext context, TarotCard card}) {
    return Consumer2<MainPageBloc, NotesChangeModel>(
      builder: (_, bloc, notesState, __) => AddNotePage(
        bloc: bloc,
        card: card,
        notesChangeModel: notesState,
      ),
    );
  }

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final DateBase dateService = new DateService();
  final formController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Languages language = globals.Globals.instance.getLanguage();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: CustomAppBar(
          children: _buildAppBarContent(),
          actions: _buildAction(),
        ),
        content: _buildContent(context));
  }

  List<Widget> _buildAction() {
    return [
      TextButton(
        onPressed: insertNote,
        child: Text(
          language.saveText,
          style: appBarTextStyle,
        ),
      )
    ];
  }

  List<Widget> _buildAppBarContent() {
    return [
      Text(
        DateService.toPresentationDate(dateService.getCurrentDate()),
        style: headerTextStyle,
      ),
    ];
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(physics: ClampingScrollPhysics(), slivers: [
        _buildTimePicker(),
        _buildHeader(),
        _buildTextBox(context),
      ]),
    );
  }

  Widget _buildTimePicker() {
    return SliverToBoxAdapter(
        child: DateTimePicker(
            onDateSelect: _onDateSelect,
            currentDate:
                DateService.toPresentationDate(dateService.getCurrentDate())));
  }

  void _onDateSelect(DateTime date) {
    _selectedDate = date;
  }

  Widget _buildHeader() {
    return NotesHeader(
      text: widget.card.name,
    );
  }

  Widget _buildTextBox(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: 1.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  color: addNoteTextViewColor,
                  child: SizedBox(
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: 250.0, left: 8.0, right: 8.0),
                        child: TextField(
                          controller: formController,
                          cursorColor: cursorColor,
                          autofocus: true,
                          style: noteInputTextStyle(),
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: language.enterNoteText,
                            labelStyle: noteHintTextStyle,
                          ),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.95),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> insertNote() async {
    String notePrefix = widget.card.isFlipped
        ? globals.Globals.instance.getLanguage().isFlipped
        : '';

    Note note = Note(
        cardImage: widget.card.image,
        cardId: widget.card.id,
        date: dateService.formatDateTime(_selectedDate),
        note: notePrefix + formController.text,
        isFlipped: widget.card.isFlipped,
        timeSaved: _selectedDate.millisecondsSinceEpoch);
    await AppDatabase.insertNote(note);
    widget.bloc.onAddNote(note);
    widget.notesChangeModel.updateNotes();
    context.read<JournalCubit>().emitJournalByDates();
    Navigator.of(context).pop();
  }
}
