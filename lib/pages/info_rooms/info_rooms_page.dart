import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meetz/core/app_colors.dart';
import 'package:meetz/pages/home/models/user_model.dart';
import 'package:meetz/pages/home/widgets/admin_button/admin_button_widget.dart';
import 'package:meetz/pages/home/widgets/colaborator_button/colaborator_button_widget.dart';
import 'package:meetz/pages/home/widgets/drawer/drawer_widget.dart';
import 'package:http/http.dart' as http;
import 'package:meetz/shared/models/info_room_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class InfoRoomsPage extends StatefulWidget {
  const InfoRoomsPage({Key? key}) : super(key: key);

  @override
  _InfoRoomsPageState createState() => _InfoRoomsPageState();
}

class _InfoRoomsPageState extends State<InfoRoomsPage> {
  late Future<InfoRoomModel?> futureRoom;

  @override
  void initState() {
    super.initState();
    futureRoom = fetchRoom();
  }

  @override
  Widget build(BuildContext context) {
    fetchRoom();
    return SafeArea(
      child: FutureBuilder<InfoRoomModel?>(
          future: futureRoom,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Text("${snapshot.data!.description}");
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

  Future<InfoRoomModel?> fetchRoom() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getStringList('config') != null) {
      List<String> map = sharedPreferences.getStringList('config') ?? [];
      String token = map[0];
      String id = map[1];
      var url = Uri.parse("${dotenv.env["URL"]}/meeting_room/${1}");
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
