import 'package:final_project/views/main_screen.dart';

import 'package:final_project/views/show_exercises.dart';
import 'package:final_project/views/show_edit.dart';
import 'package:final_project/views/show_add.dart';
import 'package:final_project/views/show_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future main() async {
  final FlutterI18nDelegate flutterI18nDelegate = FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
        useCountryCode: false,
        fallbackFile: 'en',
        basePath: 'assets/flutter_i18n'),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await flutterI18nDelegate.load(null);
  runApp(LoadingScreen(flutterI18nDelegate));
}

class LoadingScreen extends StatelessWidget {
  final FlutterI18nDelegate flutterI18nDelegate;

  LoadingScreen(this.flutterI18nDelegate);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MyFitness',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: NavigationPages(title: 'MyFitness'),
        routes: <String, WidgetBuilder>{
          '/displayExercies': (BuildContext context) =>
              DisplayExercises(title: 'Exercises for today'),
          '/settings': (BuildContext context) => Settings(title: 'Settings'),
          '/editPage': (BuildContext context) => Edit(title: 'Edit'),
          '/addPage': (BuildContext context) => Add(title: 'Add'),
        },
        localizationsDelegates: [
          flutterI18nDelegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ]);
  }
}
