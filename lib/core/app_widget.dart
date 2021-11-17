import 'package:flutter/material.dart';
import 'package:meetz/pages/signin/signin_page.dart';
import 'package:meetz/pages/signup/signup_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Meetz", home: SignUpPage()); //pagina que você vai trabalhar
  }
}
