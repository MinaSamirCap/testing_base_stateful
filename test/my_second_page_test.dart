import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:testing_base_stateful/ui/second/bloc/second_bloc.dart';
import 'package:testing_base_stateful/ui/second/my_second_page.dart';
import 'package:testing_base_stateful/utils/lang/app_localization.dart';
import 'package:testing_base_stateful/utils/lang/app_localization_keys.dart';

import 'app_localization_util_test.dart';

/// for bloc testing widgets ...
/// test flutter widget under bloc state and events
// https://stackoverflow.com/a/69262783/2172590
// https://github.com/felangel/bloc/blob/master/examples/flutter_timer/test/timer/view/timer_page_test.dart

/// localization test ...
/// https://stackoverflow.com/a/69004451/2172590

/// mocking ...
class MockSecondBloc extends MockBloc<SecondEvent, SecondState>
    implements SecondBloc {}

class FakeSecondEvent extends Fake implements SecondEvent {}

class FakeSecondState extends Fake implements SecondState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeSecondEvent());
    registerFallbackValue(FakeSecondState());
  });

  late MockSecondBloc bloc;

  setUp(() {
    bloc = MockSecondBloc();
  });

  void fakeInitSte() {
    when(() => bloc.state).thenReturn(InitialSte());
  }

  void fakeLoadingSte() {
    when(() => bloc.state).thenReturn(LoadingSte());
  }

  void fakeErrorSte() {
    when(() => bloc.state).thenReturn(ErrorSte());
  }

  void fakeLoadedSte() {
    when(() => bloc.state).thenReturn(LoadedSte());
  }

  Widget createWidgetUnderTest({String local = "en"}) {
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
        locale: Locale(local),
        home: BlocProvider<SecondBloc>(
          create: (ctx) => bloc,
          child: MySecondPageBloc(bloc),
        ));
  }

  testWidgets(
      "when the screen is opened, the float action button is displayed.",
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      fakeInitSte();
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.wifi), findsOneWidget);
    });
  });

  testWidgets(
      "when the screen is in loading state, display circular progress indicator",
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      fakeLoadingSte();
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byIcon(Icons.wifi), findsOneWidget);

    });
  });

  testWidgets("when the screen is in loaded state, display loaded text",
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      var local = "en";
      fakeLoadedSte();
      await tester.pumpWidget(createWidgetUnderTest(local: local));

      await tester.pumpAndSettle();
      var txt = await getJsonLocals(local, LangKeys.loaded);
      expect(find.text(txt), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });

  testWidgets("when the screen is in error state, display error text",
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      var local = "ar";
      fakeErrorSte();
      await tester.pumpWidget(createWidgetUnderTest(local: local));

      await tester.pumpAndSettle();
      var txt = await getJsonLocals(local, LangKeys.error);
      expect(find.text(txt), findsOneWidget);
    });
  });
}
