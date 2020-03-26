import 'dart:convert' as convert;

import 'package:flutter_carros_mobx/pages/carro/carro.dart';
import 'package:flutter_carros_mobx/pages/login/user.dart';
import 'package:http/http.dart' as http;

class TipoCarro {
  static final String classicos = 'classicos';
  static final String esportivos = 'esportivos';
  static final String luxo = 'luxo';
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    User user = await User.get();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };

    print(headers);

    var url =
        'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';

    var response = await http.get(url, headers: headers);

    String json = response.body;

    List list = convert.json.decode(json);

    final carros = list.map<Carro>((map) => Carro.fromJson(map)).toList();

    return carros;
  }
}
