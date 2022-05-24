import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_base_stateful/base/base_stateful_widget.dart';
import 'package:testing_base_stateful/ui/second/my_second_page.dart';
import 'package:testing_base_stateful/utils/lang/app_localization_keys.dart';

import 'bloc/my_home_bloc.dart';

class MyHomePage extends StatelessWidget {
  static const routeName = '/my-home-page';

  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = MyHomeBloc();
    return BlocProvider<MyHomeBloc>(
      create: (ctx) => bloc,
      child: MyHomePageBloc(bloc),
    );
  }
}

class MyHomePageBloc extends BaseStatefulWidget {
  final MyHomeBloc bloc;

  const MyHomePageBloc(this.bloc, {Key? key}) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _MyHomePageState();
}

class _MyHomePageState extends BaseState<MyHomePageBloc> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Demo"),
      ),
      body: BlocListener<MyHomeBloc, MyHomeState>(
        listener: (context, state) {
          if (state is NextScreenSte) {
            _openNextScreen();
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                translate(LangKeys.next)! + ': $_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
              heroTag: "btnNav",
              child: const Icon(Icons.navigate_next_rounded),
              onPressed: () {
                _nextScreenTap();
              }),
          const SizedBox(width: 20),
          FloatingActionButton(
            heroTag: "btnIncrement",
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper methods ////////////////////////
  ///////////////////////////////////////////////////////////

  MyHomeBloc get currentBloc => widget.bloc;

  void _nextScreenTap() {
    currentBloc.add(NextScreenEvt());
  }

  void _openNextScreen() {
    Navigator.of(context).pushNamed(MySecondPage.routeName);
  }
}
