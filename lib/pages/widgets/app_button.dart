import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String label;
  Function onPressed;

  AppButton(this.label, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: RaisedButton(
        onPressed: onPressed,
        color: Colors.blue,
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
