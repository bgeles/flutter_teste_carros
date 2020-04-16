import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carros/pages/api_response.dart';
import 'package:flutter_carros/pages/carro/home_page.dart';
import 'package:flutter_carros/pages/login/login_api.dart';
import 'package:flutter_carros/pages/login/usuario.dart';
import 'package:flutter_carros/utils/alert.dart';
import 'package:flutter_carros/utils/nav.dart';
import 'package:flutter_carros/widgets/app_button.dart';
import 'package:flutter_carros/widgets/app_text.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showProgress = false;

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
            AppButton(
              "Login",
              onPressed: _onClickLogin,
              showProgress: _showProgress,
            ),
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
    if (text.length < 2) {
      return "Senha precisa ser maior do que 2 dígitos";
    }
    return null;
  }

  void _onClickLogin() async {
    bool formOK = _formKey.currentState.validate();

    if (!formOK) {
      return;
    }

    String login = _tlogin.text;
    String senha = _tSenha.text;

    print(formOK);

    setState(() {
      _showProgress = true;
    });

    ApiResponse response = await LoginApi.login(login, senha);

    if (response.ok) {
      Usuario user = response.result;

      print(">>>>> $user");

      push(context, HomePage(), replace: true);
    } else {
      alert(context, response.msg);
      print(response.msg);
    }

    setState(() {
      _showProgress = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
