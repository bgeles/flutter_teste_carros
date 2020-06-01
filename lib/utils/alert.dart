import 'package:flutter/material.dart';
import 'package:flutter_carros/utils/nav.dart';

alert(BuildContext context, String msg, {Function callback}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text("Carros"),
            content: Text(msg),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  pop(context);
                  if(callback != null){
                    callback();
                  }
                },
              ),
            ],
          ),
        );
      });
}
