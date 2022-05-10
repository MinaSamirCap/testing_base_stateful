import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_base_stateful/ui/second/my_second_page.dart';
import 'package:testing_base_stateful/utils/lang/app_localization.dart';

void main() {
  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'FMS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      locale: const Locale(CODE_EN),
      home: const MySecondPage(),
      routes: {MySecondPage.routeName: (ctx) => const MySecondPage()},
    );
  }

  testWidgets("when the screen is displaying the float action button",
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.wifi), findsOneWidget);
  });

  testWidgets(
      "when the screen is in loading state, display circular progress indicator",
      (WidgetTester tester) async {

      });
}
