import 'dart:convert' as convert;

import 'package:flutter_carros_mobx/utils/prefs.dart';

class User {
  int id;
  String login;
  String nome;
  String email;
  String urlFoto;
  String token;
  List<String> roles;

  User(
      {this.id,
      this.login,
      this.nome,
      this.email,
      this.urlFoto,
      this.token,
      this.roles});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    nome = json['nome'];
    email = json['email'];
    urlFoto = json['urlFoto'];
    token = json['token'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['urlFoto'] = this.urlFoto;
    data['token'] = this.token;
    data['roles'] = this.roles;
    return data;
  }

  static void clear() {
    Prefs.setString('user.prefs', '');
  }

  void save() {
    Map map = toJson();

    String json = convert.json.encode(map);
    Prefs.setString('user.prefs', json);
  }

  static Future<User> get() async {
    try {
      String json = await Prefs.getString('user.prefs');

      Map map = convert.json.decode(json);

      User user = User.fromJson(map);

      return user;
    } catch (err) {}
  }

  @override
  String toString() {
    return 'User(id: $id, login: $login, nome: $nome, email: $email, urlFoto: $urlFoto, token: $token, roles: $roles)';
  }
}
