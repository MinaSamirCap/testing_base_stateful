import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:testing_base_stateful/my_home_page.dart';
import 'package:testing_base_stateful/utils/lang/app_localization.dart';
import 'package:testing_base_stateful/utils/lang/language_cubit.dart';

import 'my_second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LangCubit>(
      create: (BuildContext context) => LangCubit(),
      child: BlocBuilder<LangCubit, Locale>(
        builder: (ctx, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),

            /// the list of our supported locals for our app
            /// currently we support only 2 English and Arabic ...
            supportedLocales: AppLocalizations.supportedLocales,

            /// these delegates make sure that the localization data
            /// for the proper
            /// language is loaded ...
            localizationsDelegates: const [
              /// A class which loads the translations from JSON files
              AppLocalizations.delegate,

              /// Built-in localization of basic text
              ///  for Material widgets in Material
              GlobalMaterialLocalizations.delegate,

              /// Built-in localization for text direction LTR/RTL
              GlobalWidgetsLocalizations.delegate,

              /// Built-in localization for text direction LTR/RTL in Cupertino
              GlobalCupertinoLocalizations.delegate,

              DefaultCupertinoLocalizations.delegate
            ],

            locale: state,

            home: const MyHomePage(),
            routes: {
              MyHomePage.routeName: (ctx) => const MyHomePage(),
              MySecondPage.routeName: (ctx) => const MySecondPage()
            },
          );
        },
      ),
    );
  }
}
