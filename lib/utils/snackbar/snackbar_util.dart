import 'package:flutter/material.dart';

SnackBar createSnackBar(String message) {
  return SnackBar(
    duration: const Duration(seconds: 2),
    content: Text(message),
  );
}

void showSnackBarWithContext(SnackBar snackBar, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSnackBarMassage(String message, BuildContext context) {
  showSnackBarWithContext(createSnackBar(message), context);
}
