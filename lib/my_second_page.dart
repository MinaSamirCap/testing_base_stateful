import 'package:flutter/material.dart';
import 'package:testing_base_stateful/base/base_stateful_widget.dart';
import 'package:testing_base_stateful/utils/lang/app_localization_keys.dart';

class MySecondPage extends BaseStatefulWidget {
  static const routeName = '/my-second-page';

  const MySecondPage({Key? key}) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _MySecondPageState();
}

class _MySecondPageState extends BaseState<MySecondPage> {
  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Second"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              translate(LangKeys.REQUIRED)!,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
