import 'package:flutter/material.dart';

class AlertDialogWidget {
  static showDialogg(
      {required String? phoneNumber,
      required String subtitle,
      required Function fct,
      required BuildContext context}) async {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('You entered the phone number: \n\n$phoneNumber\n\nIs this OK, or you like to edit the number?'),
            ),
            // content: Text(subtitle),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Edit'),),
              TextButton(
                  onPressed: () {
                    fct();
                    Navigator.pop(context);
                  },
                  child: const Text('ok'),),
                ],
              ),
            ],
          );
        });
  }
}
