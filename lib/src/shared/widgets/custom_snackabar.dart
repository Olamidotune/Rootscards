import 'package:flutter/material.dart';
import 'package:rootscards/config/colors.dart';

class CustomSnackbar {
  static void show(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    final snackBar = SnackBar(
      showCloseIcon: true,
      content: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color:Colors.white),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: isError ? RED : Colors.green,
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
