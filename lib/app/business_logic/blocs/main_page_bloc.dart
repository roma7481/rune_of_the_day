import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/constants/enums/enums.dart';
import 'package:rune_of_the_day/app/constants/flipped/flipped_runes.dart';
import 'package:rune_of_the_day/app/data/models/note.dart';
import 'package:rune_of_the_day/app/data/repositories/floor_database.dart';
import 'package:rune_of_the_day/app/services/date_serivce.dart';
import 'package:rune_of_the_day/app/services/shered_preferences.dart';

import '../../data/models/card.dart';
import 'card_state_model.dart';

class MainPageBloc {
  MainPageBloc({this.dateService});

  final DateBase dateService;
  final SharedPref _sharedPref = SharedPref.instance;
  final StreamController<CardModel> _modelController =
      StreamController<CardModel>();

  Stream<CardModel> get modelStream => _modelController.stream;
  CardModel _model = CardModel();

  void dispose() {
    _modelController.close();
  }

  void updateWith({
    bool isForwardEnabled,
    bool isBackEnabled,
    CardType cardType,
    String cardName,
    TarotCard card,
    String header,
    Note note,
  }) {
    _model = _model.copyWith(
      isForwardEnabled,
      isBackEnabled,
      cardType,
      cardName,
      card,
      header,
      note,
    );

    _modelController.add(_model);
  }

  void _setSelectedCard({
    @required TarotCard card,
    @required String date,
    @required bool isForwardEnabled,
    @required bool isBackEnabled,
    @required Note note,
  }) async {
    updateWith(
      isForwardEnabled: isForwardEnabled,
      isBackEnabled: isBackEnabled,
      cardType: CardType.open,
      cardName: card.name,
      header: date,
      card: card,
      note: note,
    );
  }

  void _setDefaultCard(
      {@required bool isBackEnabled, @required String date}) async {
    TarotCard card = TarotCard();

    updateWith(
      isForwardEnabled: false,
      isBackEnabled: isBackEnabled,
      cardType: CardType.closed,
      cardName: card.name,
      header: date,
      card: card,
    );
  }

  bool _isBackEnabled({bool isCardOpen, String date}) {
    if (!isCardOpen) {
      return _sharedPref.getNumKeys() > 0;
    }
    if (_isTodayDate(date)) {
      return _sharedPref.getNumKeys() > 1;
    }
    return _sharedPref.getIndexValue() > 0;
  }

  bool _isForwardEnabled(String date) {
    return _isTodayDate(date) ? false : true;
  }

  bool _isTodayDate(String currentDate) =>
      currentDate == dateService.getCurrentDate();

  Future<void> onOpenCardPressed() async {
    if (_model.cardType == CardType.open) {
      return null;
    }
    final Random _random = new Random();
    int runeId = 1 + _random.nextInt(25);

    bool isFlipped = false;
    if (flippedRunesIds.contains(runeId)) {
      isFlipped = _random.nextBool();
    }

    await _sharedPref.storeValue(
        key: dateService.getCurrentDate(), value1: runeId, value2: isFlipped);

    TarotCard card = await TarotCard.getCardById(runeId, isFlipped);
    String date = dateService.getCurrentDate();
    bool isForwardEnabled = _isForwardEnabled(date);
    bool isBackEnabled = _isBackEnabled(isCardOpen: true, date: date);
    Note note = await _getLastNoteForCard(runeId);

    _setSelectedCard(
      card: card,
      date: date,
      isForwardEnabled: isForwardEnabled,
      isBackEnabled: isBackEnabled,
      note: note,
    );
  }

  void onAddNote(Note note) {
    if (note.cardId == _model.card.id) {
      updateWith(
        note: note,
      );
    }
  }

  void onUpdateNote() async {
    Note note = await _getLastNoteForCard(_model.card.id);
    updateWith(note: note);
  }

  void onDeleteNote() async {
    Note note = await _getLastNoteForCard(_model.card.id);
    updateWith(note: note);
  }

  Future<Note> _getLastNoteForCard(int cardId) async {
    Note note = await AppDatabase.getLastNoteForCard(cardId);
    return note == null ? Note() : note;
  }

  void onInitCard() async {
    await _sharedPref.initKeys();
    var date = dateService.getCurrentDate();
    final Map<int, bool> cardIdToIsFlipped = await _sharedPref.getValue(date);
    var cardId = cardIdToIsFlipped.keys.first;
    var isFlipped = cardIdToIsFlipped.values.first;

    if (cardId != null) {
      try {
        TarotCard card = await TarotCard.getCardById(cardId, isFlipped);
        bool isForwardEnabled = _isForwardEnabled(date);
        bool isBackEnabled = _isBackEnabled(isCardOpen: true, date: date);
        Note note = await _getLastNoteForCard(cardId);

        _setSelectedCard(
          card: card,
          date: date,
          isForwardEnabled: isForwardEnabled,
          isBackEnabled: isBackEnabled,
          note: note,
        );
      } catch (e) {
        print(e);
      }
    } else {
      bool isBackEnabled = _isBackEnabled(isCardOpen: false, date: date);
      _setDefaultCard(
          isBackEnabled: isBackEnabled, date: dateService.getCurrentDate());
    }
  }

  void onBackPressed() async {
    var headerToCardIdAndFlipped = _model.cardType == CardType.open
        ? await _sharedPref.getPrevKeyValue()
        : await _sharedPref.getPrevKeyValueForClosedCard();

    var date = headerToCardIdAndFlipped[0].toString();
    var cardId = headerToCardIdAndFlipped[1];
    var isFlipped = headerToCardIdAndFlipped[2];

    TarotCard card = await TarotCard.getCardById(cardId, isFlipped);
    Note note = await _getLastNoteForCard(cardId);

    bool isForwardEnabled = _isForwardEnabled(date);
    bool isBackEnabled = _isBackEnabled(isCardOpen: true, date: date);
    _setSelectedCard(
      card: card,
      date: date,
      isForwardEnabled: isForwardEnabled,
      isBackEnabled: isBackEnabled,
      note: note,
    );
  }

  void onForwardPressed() async {
    List headerToCardIdAndFlipped = await _sharedPref.getNextKeyValue();
    String date = headerToCardIdAndFlipped[0];
    var cardId = headerToCardIdAndFlipped[1];
    var isFlipped = headerToCardIdAndFlipped[2];

    if (cardId == null) {
      bool isBackEnabled = _isBackEnabled(isCardOpen: false, date: date);
      _setDefaultCard(
          isBackEnabled: isBackEnabled, date: dateService.getCurrentDate());
      return;
    }

    TarotCard card = await TarotCard.getCardById(cardId, isFlipped);
    Note note = await _getLastNoteForCard(cardId);
    bool isForwardEnabled = _isForwardEnabled(date);
    bool isBackEnabled = _isBackEnabled(isCardOpen: true, date: date);
    _setSelectedCard(
        card: card,
        date: date,
        isForwardEnabled: isForwardEnabled,
        isBackEnabled: isBackEnabled,
        note: note);
  }
}
