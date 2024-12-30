import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'enums/supported_locale_enum.dart';
import 'main_page.dart';

Future<void> main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final currentLocale = SupportedLocale.english;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: currentLocale.locale,
      supportedLocales: SupportedLocale.values.map((e) => e.locale).toList(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.cyan.shade500,
        primarySwatch: Colors.teal,
      ),
      home: const MainPage(),
    );
  }
}
