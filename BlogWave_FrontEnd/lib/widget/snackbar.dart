import 'package:flutter/material.dart';
import '../resources/resources.dart';

// This is the snack bar which give the update to user in perform action
class WarningBar{

  SnackBar snack(String warning,Color backgroundColor) {
    return SnackBar(
      content: Text(
        warning,
        style: const TextStyle(
            color: ColorManager.whiteColor,
            fontSize: 15,
            fontWeight:FontWeight.w600),
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
    );
  }

  static void snackMessage(BuildContext context,{required String message,required Color color}) {
    final bar = WarningBar();

    final snackMessage = bar.snack(message,  color);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackMessage);
  }
}