import 'package:flutter/material.dart';

class CustomSnackbar {
  static void show(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    final snackBar = SnackBar(
      content: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.white),
      ),
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,
      backgroundColor: isError ? Colors.red : Colors.green,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      action: SnackBarAction(
        label: 'Close',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
