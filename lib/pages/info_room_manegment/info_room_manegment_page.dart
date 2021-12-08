import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meetz/core/app_colors.dart';
import 'package:meetz/pages/home/models/user_model.dart';
import 'package:meetz/pages/home/widgets/admin_button/admin_button_widget.dart';
import 'package:meetz/pages/home/widgets/colaborator_button/colaborator_button_widget.dart';
import 'package:meetz/pages/home/widgets/drawer/drawer_widget.dart';
import 'package:http/http.dart' as http;
import 'package:meetz/pages/rooms_manegment/room_manegment_page.dart';
import 'package:meetz/shared/models/info_room_model.dart';
import 'package:meetz/shared/widgets/app_bar_back_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class InfoRoomManegmentPage extends StatefulWidget {
  final int id_room;
  const InfoRoomManegmentPage({Key? key, required this.id_room})
      : super(key: key);

  @override
  _InfoRoomManegmentPageState createState() => _InfoRoomManegmentPageState();
}

class _InfoRoomManegmentPageState extends State<InfoRoomManegmentPage> {
  late Future<InfoRoomModel?> futureRoom;

  @override
  void initState() {
    super.initState();
    futureRoom = fetchRoom(widget.id_room);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBarBackWidget(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => RoomsManegmentPage(),
                ),
              );
            },
          ),
          body: Container(
            child: FutureBuilder<InfoRoomModel?>(
                future: futureRoom,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Row(
                      children: [
                        ElevatedButton(onPressed: () {}, child: Text("Editar")),
                        ElevatedButton(
                            onPressed: () {}, child: Text("Remover")),
                      ],
                    );
                  } else if (snapshot.hasError) {}

                  return Center(
                      child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(),
                  ));
                }),
          )),
    );
  }

  Future<InfoRoomModel?> fetchRoom(int id_room) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getStringList('config') != null) {
      List<String> map = sharedPreferences.getStringList('config') ?? [];
      String token = map[0];
      String id = map[1];
      var url = Uri.parse("${dotenv.env["URL"]}/meeting_room/${id_room}");
      http.Response? response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      });

      Map<String, dynamic?> infoRoomResponse = jsonDecode(response.body);

      InfoRoomModel? teste = InfoRoomModel.fromJson(infoRoomResponse);

      if (response.statusCode == 200) {
        return teste;
      } else {
        throw Exception('Failed to load user');
      }
    }
  }
}
