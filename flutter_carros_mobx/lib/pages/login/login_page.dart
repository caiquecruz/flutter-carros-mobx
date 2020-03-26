import 'dart:async';

import 'package:flutter_carros_mobx/api/api_response.dart';
import 'package:flutter_carros_mobx/api/login_api.dart';
import 'package:flutter_carros_mobx/pages/carro/home_page.dart';
import 'package:flutter_carros_mobx/pages/login/login_bloc.dart';
import 'package:flutter_carros_mobx/pages/login/user.dart';
import 'package:flutter_carros_mobx/utils/alert.dart';
import 'package:flutter_carros_mobx/utils/nav.dart';
import 'package:flutter_carros_mobx/widgets/app_button.dart';
import 'package:flutter_carros_mobx/widgets/app_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _bloc = LoginBloc();

  final _ctrlLogin = TextEditingController();
  final _ctrlSenha = TextEditingController();

  final _focusSenha = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future<User> future = User.get();
    future.then((User user) {
      if (user != null) {
        push(context, HomePage(), replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carros'),
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
              'Login',
              'Digite o login',
              ctrl: _ctrlLogin,
              validator: _validateLogin,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              nextFocus: _focusSenha,
            ),
            SizedBox(height: 10),
            AppText(
              'Senha',
              'Digite a senha',
              ctrl: _ctrlSenha,
              password: true,
              validator: _validateSenha,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              focusNode: _focusSenha,
            ),
            SizedBox(height: 20),
            StreamBuilder<bool>(
              stream: _bloc.stream,
              initialData: false,
              builder: (context, snapshot) {
                return AppButton(
                  'Login',
                  onPressed: _onClickLogin,
                  showLoading: snapshot.data,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  _onClickLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    print("Logando..");

    String login = _ctrlLogin.text;
    String senha = _ctrlSenha.text;

    _bloc.add(true);

    ApiResponse response = await _bloc.login(login, senha);

    if (response.ok) {
      User user = response.result;
      print("Logado!");
      print("$user");
      _bloc.add(false);
      push(context, HomePage(), replace: true);
    } else {
      _bloc.add(false);
      alert(context, response.msg);
    }
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return 'Digite o texto';
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return 'Digite o texto';
    }

    if (text.length < 3) {
      return 'A senha precisa ter pelo menos 3 números';
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
