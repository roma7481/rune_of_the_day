import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/language_cubit/language_cubit.dart';
import 'package:rune_of_the_day/app/presentation/pages/settings/dialog/landuages_dialog.dart';

void displayLanguageDialog(BuildContext context) {
  SchedulerBinding.instance
      .addPostFrameCallback((_) => _showLanguageDialog(context));
}

void _showLanguageDialog(BuildContext context) {
  if (context.read<LanguageCubit>().state.firsTimeAppVisit) {
    showCupertinoModalPopup(
        context: context, builder: (context) => LanguageDialog());
  }
}
