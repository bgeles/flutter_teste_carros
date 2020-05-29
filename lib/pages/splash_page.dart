import 'package:flutter/material.dart';
import 'package:flutter_carros/pages/carros/home_page.dart';
import 'package:flutter_carros/pages/login/login_page.dart';
import 'package:flutter_carros/pages/login/usuario.dart';
import 'package:flutter_carros/utils/nav.dart';
import 'package:flutter_carros/utils/sql/db_helper.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
 
    //Inicializar o banco de dados
    Future futureA = DatabaseHelper.getInstance().db;

    Future futureB = Future.delayed(Duration(seconds: 3));

    Future<Usuario> futureC = Usuario.get();

    Future.wait([futureA, futureB, futureC]).then((List values) {
      Usuario user = values[2];
      print("user >>> ${user.toString()}");
      if (user != null) {
        push(context, HomePage(), replace: true);
      } else {
        push(context, LoginPage(), replace: true);
      }

      print(values);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
