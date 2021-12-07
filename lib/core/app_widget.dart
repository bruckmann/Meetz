import 'package:flutter/material.dart';
import 'package:meetz/pages/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Meetz",
      home: SplashPage(),
    ); //pagina que você vai trabalhar
  }
}
