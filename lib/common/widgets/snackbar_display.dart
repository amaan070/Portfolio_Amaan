import 'package:flutter/material.dart';

class SnackbarDisplay {
  void displaySnackbar(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
