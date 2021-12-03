import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meetz/core/core.dart';
import 'package:meetz/pages/splash/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatelessWidget {
  final String role;
  final String name;
  final String email;
  const DrawerWidget({
    Key? key,
    required this.role,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.all(0.0), children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(name, style: TextStyle(fontSize: 18)),
          accountEmail: Text(email),
          decoration: BoxDecoration(color: AppColors.green600),
        ),
        role != "admin"
            ? ListTile(
                title: Text(
                  'Consultar salas',
                  style: TextStyle(color: AppColors.green800),
                ),
                leading: Icon(
                  Icons.meeting_room,
                  color: AppColors.green800,
                ),
              )
            : Column(
                children: [
                  ListTile(
                    title: Text(
                      'Gerenciar usuarios',
                      style: TextStyle(color: AppColors.green800),
                    ),
                    leading: Icon(
                      Icons.group_add,
                      color: AppColors.green800,
                    ),
                    onLongPress: () {},
                  ),
                  ListTile(
                    title: Text(
                      'Gerenciar salas',
                      style: TextStyle(color: AppColors.green800),
                    ),
                    leading: Icon(
                      Icons.room_preferences,
                      color: AppColors.green800,
                    ),
                    onLongPress: () {},
                  ),
                  ListTile(
                    title: Text(
                      'Consultar salas',
                      style: TextStyle(color: AppColors.green800),
                    ),
                    leading: Icon(
                      Icons.meeting_room,
                      color: AppColors.green800,
                    ),
                    onLongPress: () {},
                  ),
                ],
              ),
        Divider(),
        ListTile(
          title: Text(
            'Sair',
            style: TextStyle(color: AppColors.green800),
          ),
          leading: Icon(
            Icons.logout,
            color: AppColors.green800,
          ),
          onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: Text("Você deseja mesmo sair?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Não",
                          style: TextStyle(color: AppColors.green800),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await signOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SplashPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Sim",
                          style: TextStyle(color: AppColors.green800),
                        ),
                      ),
                    ],
                  )),
        ),
      ]),
    );
  }

  Future<bool> signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }
}
