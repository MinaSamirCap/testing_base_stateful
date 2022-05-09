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
import 'package:testing_base_stateful/ui/home/my_home_page.dart';
import 'package:testing_base_stateful/ui/second/my_second_page.dart';
import 'package:testing_base_stateful/utils/lang/app_localization.dart';
import 'package:testing_base_stateful/utils/lang/app_localization_keys.dart';

import 'app_localization_util_test.dart';

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

      locale: const Locale(CODE_AR),

      home: const MyHomePage(),

      routes: {
        MyHomePage.routeName: (ctx) => const MyHomePage(),
        MySecondPage.routeName: (ctx) => const MySecondPage()
      },
    );
  }

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(createWidgetUnderTest());
    var keyString = await getJsonLocals("ar", LangKeys.next);
    await tester.pumpAndSettle();

    // Verify that our counter starts at 0.
    expect(find.text('$keyString: 0'), findsOneWidget);
    expect(find.text('$keyString: 1'), findsNothing);
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('$keyString: 0'), findsNothing);
    expect(find.text('$keyString: 1'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.navigate_next_rounded));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Second screen displayed', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Tap the '>' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.navigate_next_rounded));
    await tester.pump();

    // Verify that wifi icon is exits in the second screen.
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.wifi), findsOneWidget);
  });
}
