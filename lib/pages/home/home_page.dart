import 'package:flutter/material.dart';
import 'package:meetz/core/app_colors.dart';
import 'package:meetz/pages/home/widgets/admin_button/admin_button_widget.dart';
import 'package:meetz/pages/home/widgets/colaborator_button/colaborator_button_widget.dart';
import 'package:meetz/pages/home/widgets/drawer/drawer_widget.dart';

import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  final String? id;
  
  const HomePage({ Key? key, this.id }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
 
}

class _HomePageState extends State<HomePage> {
  
  final String role = "admin";
  final String name = "Jardel";
  final String email = "teste@example.com";

 @override 
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.green600,
        ),
        drawer: DrawerWidget(
          name: name,
          email: email,
          role: role,
        ),
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(children: [
              Container(
                  decoration: BoxDecoration(
                    color: AppColors.green600,
                  ),
                  child: SizedBox(
                    height: 160,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Bem vindo, Jardel!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Boa tarde!",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 115),
                child: role != "admin"
                    ? ColaboratorButtonWidget()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AdminButtonWidget(
                              title: "Gerenciar usuarios",
                              icon: Icons.group_add,
                            ),
                            AdminButtonWidget(
                              title: "Gerenciar salas",
                              icon: Icons.room_preferences,
                            ),
                            AdminButtonWidget(
                              title: "Consultar salas",
                              icon: Icons.meeting_room,
                            ),
                          ],
                        ),
                      ),
              ),
            ]),
            SizedBox(
              height: 30,
            ),
            Container(
                child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Agendamentos recentes",
                        style: TextStyle(
                            color: AppColors.green800,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.green800,
                      ),
                    ],
                  ),
                ],
              ),
            )),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future<String> getAppoitments(String? response) async {

    var formatedResponse = widget.id.toString().split(',');

    String idToken = "${formatedResponse[0]}}";

    var url = Uri.parse("http://localhost:3000/login${idToken}");


    http.Response? resposta = await http.get(url);

    if (resposta.statusCode == 200) {
 
    return idToken;
    } else{
       throw("error");
    } 
  }
}