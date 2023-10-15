import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class ShowDialog {
  static void show(
      BuildContext context, String message, DialogType dialogType) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: dialogType,
      body: Center(
        child: Text(
          message,
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      btnOkOnPress: () {
        Navigator.pop(context);
      },
    ).show();
  }
}
