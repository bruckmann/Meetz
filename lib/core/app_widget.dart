import 'package:flutter/material.dart';
import 'package:meetz/core/splash_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Meetz", home: SplashPage()); //pagina que você vai trabalhar
  }
}
