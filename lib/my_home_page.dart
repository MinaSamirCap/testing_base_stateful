import 'package:flutter/material.dart';
import 'package:testing_base_stateful/base/base_stateful_widget.dart';
import 'package:testing_base_stateful/my_second_page.dart';
import 'package:testing_base_stateful/utils/lang/app_localization_keys.dart';

class MyHomePage extends BaseStatefulWidget {
  static const routeName = '/my-home-page';

  const MyHomePage({Key? key}) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _MyHomePageState();
}

class _MyHomePageState extends BaseState<MyHomePage> {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              translate(LangKeys.NEXT)! + ': $_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
              child: const Icon(Icons.navigate_next_rounded),
              onPressed: () {
                Navigator.of(context).pushNamed(MySecondPage.routeName);
              }),
          const SizedBox(width: 20),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
