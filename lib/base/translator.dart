import 'package:flutter/material.dart';
import 'package:testing_base_stateful/utils/lang/app_localization.dart';

/// Always keep in mind that mixin is not multiple inheritance instead
/// they are just a way to reuse our code from a class in multiple hierarchies
/// without needing to extend them.
/// Its like being able to use other people assets
/// without being their children. Its cool hah! 😝

mixin Translator {
  AppLocalizations? appLocal;

  void initAppLocals(BuildContext context) {
    appLocal = AppLocalizations.of(context);
  }

  String? translate(String key) {
    return appLocal!.translate(key);
  }
}

/// mixin can not be extendable ...
///
/// reference
/// https://medium.com/flutter-community/https-medium-com-shubhamhackzz-dart-for-flutter-mixins-in-dart-f8bb10a3d341
