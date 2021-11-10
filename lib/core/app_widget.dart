import 'package:flutter/material.dart';
import 'package:meetz/home/home_page.dart';
import 'package:meetz/login/login_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Meetz", home: LoginPage()); //pagina que você vai trabalhar
  }
}
