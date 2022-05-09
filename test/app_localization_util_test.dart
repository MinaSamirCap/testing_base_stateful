import 'dart:convert';

import 'package:flutter/services.dart';

Future<String> getJsonLocals(String local, String key) async {
  var jsonString = await rootBundle.loadString('lang/$local.json');
  Map<String, dynamic> jsonMap =
      json.decode(jsonString) as Map<String, dynamic>;

  var _localizedStrings = jsonMap.map((key, value) {
    return MapEntry(key, value.toString());
  });

  if (_localizedStrings[key] != null) {
    return _localizedStrings[key]!;
  } else {
    throw Exception("The key or local file does not exist");
  }
}
