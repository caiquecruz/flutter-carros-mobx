import 'package:flutter_carros_mobx/pages/login/login_page.dart';
import 'package:flutter_carros_mobx/pages/login/user.dart';
import 'package:flutter_carros_mobx/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  UserAccountsDrawerHeader _header(User user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.nome),
      accountEmail: Text(user.email),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(user.urlFoto),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<User> future = User.get();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  User user = snapshot.data;

                  return user != null ? _header(user) : Container();
                }),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Favoritos'),
              subtitle: Text('Confira seus favoritos'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print('Fav');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Ajuda'),
              subtitle: Text('Ajuda..'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print('Fav');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () => _onClickLogout(context),
            )
          ],
        ),
      ),
    );
  }

  _onClickLogout(BuildContext context) {
    User.clear();
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
