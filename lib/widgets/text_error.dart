import 'package:flutter/material.dart';

class TextError extends StatelessWidget {
  String msg;

  TextError(this.msg);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        msg,
        style: TextStyle(
          color: Colors.red,
          fontSize: 22,
        ),
      ),
    );
  }
}
