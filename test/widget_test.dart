// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:testing_base_stateful/main.dart';
import 'package:testing_base_stateful/my_home_page.dart';
import 'package:testing_base_stateful/utils/lang/app_localization.dart';

void main() {
  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'FMS',
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

      locale: const Locale(CODE_EN),

      home: const MyHomePage(title: "Flutter Demo Home Page"),

      /*routes: {
        NormalUserHomeScreen.ROUTE_NAME: (ctx) => NormalUserHomeScreen(),
        LoginMailScreen.ROUTE_NAME: (ctx) => LoginMailScreen(),
        SettingScreen.ROUTE_NAME: (ctx) => SettingScreen()
      },*/
    );
  }

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Verify that our counter starts at 0.
    expect(find.text('Next: 0'), findsOneWidget);
    expect(find.text('Next: 1'), findsNothing);
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('Next: 0'), findsNothing);
    expect(find.text('Next: 1'), findsOneWidget);
  });
}
