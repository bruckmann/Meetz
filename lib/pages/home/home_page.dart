import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meetz/core/core.dart';
import 'package:meetz/pages/home/models/user_model.dart';
import 'package:meetz/pages/home/widgets/admin_button/admin_button_widget.dart';
import 'package:meetz/pages/home/widgets/check_appointments/check_appointments_widget.dart';
import 'package:meetz/pages/home/widgets/colaborator_button/colaborator_button_widget.dart';
import 'package:meetz/pages/home/widgets/drawer/drawer_widget.dart';
import 'package:http/http.dart' as http;
import 'package:meetz/pages/home/widgets/recent_appointments/recent_appointments.dart';
import 'package:meetz/pages/rooms/list_rooms_page.dart';
import 'package:meetz/pages/rooms_manegment/room_manegment_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<UserModel?> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<UserModel?>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: AppColors.green600,
                ),
                drawer: DrawerWidget(
                  name: snapshot.data!.name,
                  email: snapshot.data!.email,
                  role: snapshot.data!.role,
                ),
                bottomSheet: Padding(
                  padding: const EdgeInsets.only(left: 140, bottom: 10),
                  child: SvgPicture.asset(
                    'assets/images/logo.svg',
                    height: 70,
                    alignment: Alignment.center,
                  ),
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
                                  padding: const EdgeInsets.only(
                                      left: 20, bottom: 25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Bem vindo, ${snapshot.data!.name}!",
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
                        child: snapshot.data!.role != "ADMIN"
                            ? ColaboratorButtonWidget()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 35),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AdminButtonWidget(
                                      title: "Gerenciar usuarios",
                                      icon: Icons.group_add,
                                    ),
                                    AdminButtonWidget(
                                        title: "Gerenciar salas",
                                        icon: Icons.room_preferences,
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RoomsManegmentPage()));
                                        }),
                                    AdminButtonWidget(
                                        title: "Consultar salas",
                                        icon: Icons.meeting_room,
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RoomsPage()));
                                        }),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Agendamentos recentes",
                                style: TextStyle(
                                    color: AppColors.green800,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              CheckAppointmentsWidget()
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: RecentAppointmentsWidget(),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              );
            } else if (snapshot.hasError) {}

            return Center(
                child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ));
          }),
    );
  }

  Future<UserModel?> fetchUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getStringList('config') != null) {
      List<String> map = sharedPreferences.getStringList('config') ?? [];
      String token = map[0];
      String id = map[1].toString();

      var url = Uri.parse("${dotenv.env["URL"]}/user/${id}");
      http.Response? response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load user');
      }
    }
  }
}
