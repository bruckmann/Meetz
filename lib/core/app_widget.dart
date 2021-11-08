import 'package:flutter/material.dart';
import 'package:meetz/home/home_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Meetz", home: HomePage()); //pagina que você vai trabalhar
  }
}
