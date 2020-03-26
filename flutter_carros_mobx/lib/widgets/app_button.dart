import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String text;
  Function onPressed;
  bool showLoading;

  AppButton(this.text, {this.onPressed, this.showLoading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: RaisedButton(
        color: Colors.blue,
        child: showLoading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  // backgroundColor: Colors.white,
                ),
              )
            : Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
        onPressed: onPressed,
      ),
    );
  }
}
