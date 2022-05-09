import 'package:flutter/material.dart';
import 'package:testing_base_stateful/base/translator.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({
    Key? key,
  }) : super(key: key);

  @override
  BaseState createState() => baseCreateState();

  BaseState baseCreateState();
}

abstract class BaseState<W extends BaseStatefulWidget> extends State<W>
    with Translator {
  @override
  Widget build(BuildContext context) {
    initAppLocals(context);

    return baseWidget();
  }

  Widget baseWidget() {
    return Material(
      child: Stack(
        fit: StackFit.loose,
        alignment: AlignmentDirectional.center,
        children: [baseBuild(context)],
      ),
    );
  }

  Widget baseBuild(BuildContext context);
}
