import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/card_description_cubit/card_description_cubit.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/journal_cubit/journal_cubit.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';
import 'package:rune_of_the_day/app/data/models/card.dart';
import 'package:rune_of_the_day/app/data/models/note.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/card_category/card_button.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/card_category/card_header.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/card_category/category_list_builder.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_app_bar.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_scuffold.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/error_dialog.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/progress_bar.dart';
import 'package:rune_of_the_day/app/presentation/pages/card_description/description_card.dart';
import 'package:rune_of_the_day/app/presentation/pages/main/notes_card.dart';

class TarotDeckCardDescription extends StatelessWidget {
  const TarotDeckCardDescription({Key key, this.cardId}) : super(key: key);
  final int cardId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CardDescriptionCubit>(
      create: (BuildContext context) => CardDescriptionCubit(cardId),
      child: BlocListener<JournalCubit, JournalState>(
          ///rebuild page on add notes change
          listener: (context, state) {
            context
                .read<CardDescriptionCubit>()
                .emitCardDescriptionReady(cardId: cardId);
          },
          child: _builder()),
    );
  }

  BlocBuilder<CardDescriptionCubit, CardDescriptionState> _builder() {
    return BlocBuilder<CardDescriptionCubit, CardDescriptionState>(
        builder: (context, state) {
      if (state is CardDescriptionReady) {
        return buildContent(context, state.card, state.note);
      } else if (state is CardDescriptionNoteUpdate) {
        return buildContent(context, state.card, state.note);
      } else if (state is CardDescriptionError) {
        return errorDialog();
      }
      return progressBar();
    });
  }

  Widget buildContent(BuildContext context, TarotCard card, Note note) {
    return CustomScaffold(
        appBar: CustomAppBar(children: [
          Text(globals.Globals.instance.getLanguage().runeCard,
              style: headerTextStyle),
        ]),
        content: SafeArea(
          child: _buildPageContent(context, card, note),
        ));
  }

  CustomScrollView _buildPageContent(
    BuildContext context,
    TarotCard card,
    Note note,
  ) {
    return CustomScrollView(
      slivers: [
        _buildCardHeader(card.name),
        _buildCardButton(Image.asset(card.image)),
        _buildDescriptionCard(card),
        _buildNotesCard(context, card, note),
        _buildCardList(card),
      ],
    );
  }

  Widget _buildNotesCard(BuildContext context, TarotCard card, Note note) {
    return buildNotesCard(
      note: note,
      card: card,
      context: context,
    );
  }

  Widget _buildDescriptionCard(TarotCard card) {
    return buildDescriptionCard(
      descriptionCategory: card.descriptionCategory,
      isClosedCard: false,
    );
  }

  Widget _buildCardHeader(String headerText) {
    return CardHeader(
      topPadding: 7.0,
      text: headerText,
    );
  }

  Widget _buildCardButton(Widget image) {
    return CardButton(
      image: image,
      onPressed: () => {},
    );
  }

  Widget _buildCardList(TarotCard card) {
    return ListTileBuilder(card: card, isSelectNewCard: false);
  }
}
