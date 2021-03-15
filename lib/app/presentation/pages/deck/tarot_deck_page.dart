import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/deck_cubit/deck_cubit.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/language_cubit/language_cubit.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;
import 'package:rune_of_the_day/app/constants/styles/colours.dart';
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';
import 'package:rune_of_the_day/app/data/models/deck.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_app_bar.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_scuffold.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/error_dialog.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/progress_bar.dart';
import 'package:rune_of_the_day/app/presentation/pages/deck/tarot_deck_card.dart';

class TarotDeckPage extends StatefulWidget {
  @override
  _TarotDeckPageState createState() => _TarotDeckPageState();
}

class _TarotDeckPageState extends State<TarotDeckPage> {
  bool isSearching = false;
  List<TarotDeckCard> filteredCards = [];
  List<TarotDeckCard> allCards = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<LanguageCubit, LanguageState>(
      ///rebuild deck page on language change
      listener: (context, state) {
        context.read<DeckCubit>().emitDeckCardsReady();
      },
      child: BlocBuilder<DeckCubit, DeckState>(builder: (context, state) {
        if (state is DeckCardsReady) {
          allCards = state.allCards;
          return buildContent(allCards);
        } else if (state is DeckError) {
          return errorDialog();
        }
        return progressBar();
      }),
    );
  }

  Widget buildContent(List<TarotDeckCard> tarotCards) {
    allCards = allCards.length == 0 ? tarotCards : allCards;
    Widget header =
        !isSearching ? disabledSearchHeader() : enabledSearchHeader();

    return CustomScaffold(
        appBar: CustomAppBar(
          children: [
            header,
          ],
          actions: [
            isSearching ? enabledSearchAction() : disabledSearchAction()
          ],
        ),
        content: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverGrid(
                delegate: _buildList(getCards()),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.8),
                ),
              )
            ],
          ),
        ));
  }

  SizedBox enabledSearchHeader() {
    return SizedBox(
      width: 200,
      child: TextField(
        cursorColor: cursorColor,
        autofocus: true,
        onChanged: (string) {
          setState(() {
            filteredCards = allCards
                .where((card) =>
                    (card.name.toLowerCase().contains(string.toLowerCase()) ||
                        card.name.toLowerCase().contains(string.toLowerCase())))
                .toList();
          });
        },
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.white),
          hintText: globals.Globals.instance.getLanguage().searchRuneDeck,
          hintStyle: hintTextStyle,
          focusedBorder: new UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Text disabledSearchHeader() => Text(
        globals.Globals.instance.getLanguage().runeDeck,
        style: headerTextStyle,
      );

  IconButton disabledSearchAction() {
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        setState(() {
          this.filteredCards = allCards;
          this.isSearching = true;
        });
      },
    );
  }

  IconButton enabledSearchAction() {
    return IconButton(
      icon: Icon(Icons.close),
      onPressed: () {
        setState(() {
          this.filteredCards = [];
          this.isSearching = false;
        });
      },
    );
  }

  List<TarotDeckCard> getCards() {
    return isSearching ? filteredCards : allCards;
  }

  SliverChildBuilderDelegate _buildList(List<TarotDeckCard> tarotCards) {
    return SliverChildBuilderDelegate(
      (context, index) {
        TarotDeckCard tarotCard = tarotCards[index];
        return TarotDeckCardWidget(card: tarotCard);
      },
      childCount: tarotCards.length,
      addAutomaticKeepAlives: false,
    );
  }
}
