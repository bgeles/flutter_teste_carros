import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carros/widgets/app_button.dart';
import 'package:flutter_carros/widgets/app_text.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _tlogin = TextEditingController();

  final _tSenha = TextEditingController();

  final _focusSenha = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Carros",
        ),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText(
              "Login",
              "Digite seu login",
              obscured: false,
              controller: _tlogin,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              nextFocus: _focusSenha,
            ),
            SizedBox(
              height: 10,
            ),
            AppText(
              "Senha",
              "Digite sua senha",
              obscured: true,
              controller: _tSenha,
              validator: _validateSenha,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              focusNode: _focusSenha,
            ),
            SizedBox(
              height: 20,
            ),
            AppButton("Login", onPressed: _onClickLogin),
          ],
        ),
      ),
    );
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Digite o Login";
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Digite a Senha";
    }
    if (text.length < 5) {
      return "Senha precisa ser maior do que 4 dígitos";
    }
    return null;
  }

  void _onClickLogin() {
    bool formOK = _formKey.currentState.validate();

    if (!formOK) {
      return;
    }

    String login = _tlogin.text;
    String senha = _tSenha.text;

    print(formOK);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
