import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rune_of_the_day/app/business_logic/blocs/card_state_model.dart';
import 'package:rune_of_the_day/app/business_logic/blocs/main_page_bloc.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/language_cubit/language_cubit.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/rate_us/rate_us_cubit.dart';
import 'package:rune_of_the_day/app/constants/enums/enums.dart';
import 'package:rune_of_the_day/app/constants/styles/icons.dart';
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/card_category/card_button.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/card_category/card_header.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/card_category/category_list_builder.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_app_bar.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_scuffold.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_stream_builder.dart';
import 'package:rune_of_the_day/app/presentation/pages/card_description/description_card.dart';
import 'package:rune_of_the_day/app/services/date_serivce.dart';
import 'package:rune_of_the_day/app/services/shered_preferences.dart';

import 'navigation_button.dart';
import 'notes_card.dart';

class MainPageBlocBased extends StatefulWidget {
  const MainPageBlocBased({Key? key, required this.bloc, this.cubit})
      : super(key: key);

  final MainPageBloc bloc;
  final LanguageCubit? cubit;

  static Widget create(BuildContext context) {
    return Consumer2<MainPageBloc, LanguageCubit>(
      builder: (_, bloc, cubit, __) => MainPageBlocBased(
        bloc: bloc,
        cubit: cubit,
      ),
    );
  }

  @override
  _MainPageBlocBasedState createState() => _MainPageBlocBasedState();
}

class _MainPageBlocBasedState extends State<MainPageBlocBased>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    _initSharedPref();
    WidgetsBinding.instance.addObserver(this);
    widget.bloc.onInitCard();
    context.read<RateUsCubit>().emitIncreaseAppLaunchedCounter();
  }

  Future _initSharedPref() async {
    await SharedPref.instance.initKeys();
  }

  @override
  void didChangeAppLifecycleState(final AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      widget.bloc.onInitCard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LanguageCubit, LanguageState>(
      listener: (context, state) {
        widget.bloc.onInitCard();
      },
      child: buildCustomStream<CardModel>(
        streamMethod: widget.bloc.modelStream,
        builder: buildContent,
      ),
    );
  }

  Widget buildContent(CardModel? model) {
    return CustomScaffold(
        appBar: CustomAppBar(
          children: _buildAppBarContent(model!),
        ),
        content: _buildPageContent(model));
  }

  List<Widget> _buildAppBarContent(CardModel model) {
    return [
      NavigationButton(
        icon: backButtonIcon,
        onClick: widget.bloc.onBackPressed,
        isEnabled: model.isBackEnabled,
      ),
      Text(DateService.toPresentationDate(model.header)!,
          style: headerTextStyle),
      NavigationButton(
        icon: forwardButtonIcon,
        onClick: widget.bloc.onForwardPressed,
        isEnabled: model.isForwardEnabled,
      ),
    ];
  }

  CustomScrollView _buildPageContent(CardModel model) {
    return CustomScrollView(
      slivers: [
        _buildCardHeader(model),
        _buildCardButton(model),
        _buildDescriptionCard(model),
        _buildNotesCard(model),
        _buildCardList(model)
      ],
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Widget _buildDescriptionCard(CardModel model) {
    return buildDescriptionCard(
      descriptionCategory: model.card.descriptionCategory,
      isClosedCard: model.cardType == CardType.closed,
    );
  }

  Widget _buildNotesCard(CardModel model) {
    return buildNotesCard(
      isVisible: model.cardType != CardType.closed,
      context: context,
      card: model.card,
      note: model.note,
    );
  }

  Widget _buildCardList(CardModel model) {
    return ListTileBuilder(
      card: model.card,
      isSelectNewCard: model.cardType == CardType.closed,
    );
  }

  Widget _buildCardHeader(CardModel model) {
    return CardHeader(
      isVisible: model.isHeaderVisible,
      text: model.card.name,
    );
  }

  Widget _buildCardButton(CardModel model) {
    return CardButton(
      image: model.image,
      onPressed: () async {
        widget.bloc.onOpenCardPressed();
      },
    );
  }
}
