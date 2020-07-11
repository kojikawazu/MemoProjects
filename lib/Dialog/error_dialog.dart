import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Error_dialog {
  static const String NAME_OK = 'OK';

  Future ShowDialog(BuildContext context, String e) async{
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(e.toString()),
          actions: <Widget>[
            FlatButton(
              child: Text(NAME_OK),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}