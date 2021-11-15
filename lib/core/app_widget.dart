import 'package:flutter/material.dart';
import 'package:meetz/pages/login/login_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Meetz", home: LoginPage()); //pagina que você vai trabalhar
  }
}
