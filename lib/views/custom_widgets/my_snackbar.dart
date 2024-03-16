import 'package:flutter/material.dart';

class SnackBarHelper {
  static void showSnackbar(BuildContext context, String content) {
    final snackBar = SnackBar(
      content: Text(content),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
