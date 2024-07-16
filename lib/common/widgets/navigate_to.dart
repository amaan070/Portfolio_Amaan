import 'package:flutter/material.dart';

class NavigateTo {
  void goTo({required BuildContext context, required Widget destination}) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => destination));
  }

  void replaceAndGoTo(
      {required BuildContext context, required Widget destination}) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => destination));
  }
}
