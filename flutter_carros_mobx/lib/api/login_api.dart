import 'dart:convert';

import 'package:flutter_carros_mobx/api/api_response.dart';
import 'package:flutter_carros_mobx/pages/login/user.dart';
import 'package:flutter_carros_mobx/utils/prefs.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<User>> login(String login, String senha) async {
    try {
      var url = 'https://carros-springboot.herokuapp.com/api/v2/login';
      Map params = {
        "username": login,
        "password": senha,
      };

      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      String s = json.encode(params);

      var response = await http.post(url, body: s, headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = User.fromJson(mapResponse);

        user.save();

        User user2 = await User.get();

        print('user2: $user2');

        return ApiResponse.ok(user);
      }

      return ApiResponse.error(mapResponse['error']);
    } catch (error, exception) {
      print('Erro no login $error > $exception');

      return ApiResponse.error('Não foi possível fazer o login.');
    }
  }
}
