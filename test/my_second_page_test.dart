import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:testing_base_stateful/api/api_manager.dart';
import 'package:testing_base_stateful/ui/second/bloc/second_bloc.dart';
import 'package:testing_base_stateful/ui/second/my_second_page.dart';
import 'package:testing_base_stateful/ui/second/repository/second_repository.dart';
import 'package:testing_base_stateful/utils/lang/app_localization.dart';

/// for bloc testing widgets ...
/// test flutter widget under bloc state and events
// https://stackoverflow.com/a/69262783/2172590

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

  void fakeLoadingSte() {
    when(() => bloc.state).thenReturn(LoadingSte());
  }

  void fakeLoadedSte() {
    when(() => bloc.state).thenReturn(LoadedSte());
  }

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
        home: BlocProvider<SecondBloc>(
          create: (ctx) => bloc,
          child: MySecondPageBloc(bloc),
        ));
  }

  testWidgets("when the screen is displaying the float action button",
          (WidgetTester tester) async {
        // Build our app and trigger a frame.
        fakeLoadingSte();
        await tester.pumpWidget(createWidgetUnderTest());

        /// force widget to rebuild.
        //await tester.pump(const Duration(milliseconds: 500));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.wifi), findsOneWidget);
      });

  testWidgets(
      "when the screen is in loading state, display circular progress indicator",
          (WidgetTester tester) async {
        fakeLoadingSte();
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pump(const Duration(milliseconds: 500));
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        fakeLoadedSte();
        await tester.pumpAndSettle();
      });

  testWidgets("when the screen is in loaded state, display loaded text",
          (WidgetTester tester) async {
        fakeLoadedSte();
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pumpAndSettle();

        expect(find.text("Loaded"), findsOneWidget);
      });
}
