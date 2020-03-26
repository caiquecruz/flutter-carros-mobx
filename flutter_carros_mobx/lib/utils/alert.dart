import 'package:flutter/material.dart';

alert(BuildContext context, String msg) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          child: AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'),
              )
            ],
            title: Text('Flutter is awesome! :)'),
            content: Text(msg),
          ),
          onWillPop: () async => false,
        );
      });
}
