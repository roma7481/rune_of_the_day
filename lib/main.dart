import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_funding_choices/flutter_funding_choices.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/deck_cubit/deck_cubit.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/language_cubit/language_cubit.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/notifications_cubit/notifications_cubit.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/purchases/purchases_cubit.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/rate_us/rate_us_cubit.dart';

import 'app/business_logic/blocs/main_page_bloc.dart';
import 'app/business_logic/change_notifiers/notes_change_model.dart';
import 'app/business_logic/cubites/journal_cubit/journal_cubit.dart';
import 'app/business_logic/cubites/text_size_cubit/text_size_cubit.dart';
import 'app/constants/styles/constants.dart';
import 'app/presentation/common_widgets/progress_bar.dart';
import 'app/presentation/pages/bottom_navigation/home_page.dart';
import 'app/services/ads/ad_service.dart';
import 'app/services/date_serivce.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  ///We need to initialize the the widget bindings prior calling to the native code
  WidgetsFlutterBinding.ensureInitialized();

  await AdManager.setup();

  ///Connection between the hydrated bloc to the device storage
  ///this is the call to the native code
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  var initializationSettingsAndroid =
  AndroidInitializationSettings(androidAppIcon);
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
        if (payload != null) {
          debugPrint('notification payload: ' + payload);
        }
      });

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

Future _displayFundingdialog() async {
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    ConsentInformation consentInfo =
    await FlutterFundingChoices.requestConsentInformation();
    if (consentInfo.isConsentFormAvailable &&
        consentInfo.consentStatus == ConsentStatus.REQUIRED_IOS) {
      await FlutterFundingChoices.showConsentForm();
      // You can check the result by calling `FlutterFundingChoices.requestConsentInformation()` again !
    }
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MainPageBloc>(
            create: (_) => MainPageBloc(dateService: new DateService())),
        ChangeNotifierProvider<NotesChangeModel>(
            create: (_) => NotesChangeModel()),
        BlocProvider<JournalCubit>(
          create: (context) => JournalCubit(),
        ),
        BlocProvider<DeckCubit>(
          create: (context) => DeckCubit(),
        ),
        BlocProvider<RateUsCubit>(
          create: (context) => RateUsCubit(),
        ),
        BlocProvider<NotificationsCubit>(
          create: (context) => NotificationsCubit(),
        ),
        BlocProvider<PurchasesCubit>(
          create: (context) => PurchasesCubit(),
          lazy: false,
        ),
        BlocProvider<TextSizeCubit>(
          create: (context) => TextSizeCubit(),
          lazy: false,

          ///we always want to load this bloc at the start, because it holds the app state
        ),
        BlocProvider<LanguageCubit>(
          create: (context) => LanguageCubit(),
          lazy: false,

          ///we always want to load this bloc at the start, because it holds the app state
        ),
      ],
      child: MaterialApp(
        title: 'Tarot - Card of the day',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: _displayHomePage(),
      ),
    );
  }

  FutureBuilder<PermissionStatus> _displayHomePage() {
    return FutureBuilder(
        future: NotificationPermissions.getNotificationPermissionStatus(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == PermissionStatus.granted ||
                snapshot.data == PermissionStatus.denied ||
                snapshot.data == PermissionStatus.provisional) {
              _displayFundingdialog();
              return HomePage();
            }
          }
          return progressBar();
        });
  }
}
