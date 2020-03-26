import 'dart:async';

import 'package:flutter_carros_mobx/api/api_response.dart';
import 'package:flutter_carros_mobx/api/login_api.dart';
import 'package:flutter_carros_mobx/base_bloc.dart';
import 'package:flutter_carros_mobx/pages/login/user.dart';

class LoginBloc extends BaseBloc<bool> {
  Future<ApiResponse<User>> login(String login, String senha) async {
    add(true);

    ApiResponse response = await LoginApi.login(login, senha);

    add(false);

    return response;
  }
}
