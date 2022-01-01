import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:note_provider/prefs/app_settings_prefs.dart';
import 'package:note_provider/provider/language_change_notifier_provider.dart';
import 'package:note_provider/provider/note_provider.dart';
import 'package:note_provider/screens/about_app_screen.dart';
import 'package:note_provider/screens/add_note_screen.dart';
import 'package:note_provider/screens/launch_screen.dart';
import 'package:note_provider/screens/main_screen.dart';
import 'package:note_provider/screens/note_screen.dart';
import 'package:note_provider/screens/settings_screen.dart';
import 'package:note_provider/storage/db/db_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbProvider().initDb();
  await AppSettingsPreferences().initPreferences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NoteProvider>(create: (_) => NoteProvider()),
        ChangeNotifierProvider<LanguageChangeNotifierProvider>(create: (_) => LanguageChangeNotifierProvider()),
      ],
      child: MainMaterialApp(),
    );
  }
}

class MainMaterialApp extends StatelessWidget {
  const MainMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('ar')
      ],
      locale: Locale(Provider.of<LanguageChangeNotifierProvider>(context).languageCode),
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen': (context) => LaunchScreen(),
        '/main_screen': (context) => MainScreen(),
        '/add_note_screen': (context) => AddNoteScreen(),
        '/note_screen': (context) => NoteScreen(),
        '/settings_screen': (context) => SettingsScreen(),
        '/about_app_screen': (context) => AboutAppScreen(),
      },
    );
  }
}
