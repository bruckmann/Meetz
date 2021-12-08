import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meetz/pages/create_room/create_room_page.dart';
import 'package:meetz/pages/rooms_manegment/widgets/button_add/button_add_widget.dart';
import 'package:meetz/pages/rooms_manegment/widgets/room_manegment_data/room_data_widget.dart';
import 'package:meetz/shared/models/room_model.dart';
import 'package:meetz/shared/widgets/app_bar_back_widget.dart';
import 'package:meetz/shared/widgets/page_title_widget.dart';
import 'package:meetz/shared/widgets/room_empty_widget.dart';
import 'package:meetz/shared/widgets/room_loading_widget.dart';
import 'package:meetz/shared/widgets/room_search_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RoomsManegmentPage extends StatefulWidget {
  const RoomsManegmentPage({Key? key}) : super(key: key);

  @override
  _RoomsManegmentPageState createState() => _RoomsManegmentPageState();
}

class _RoomsManegmentPageState extends State<RoomsManegmentPage> {
  late Future<List<RoomModel>?> futureRoom;

  @override
  void initState() {
    super.initState();
    futureRoom = fetchRoom();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarBackWidget(),
        body: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PageTitleWidget(title: "Gerenciar salas"),
                      ButtonAddWidget(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateRoomPage(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      RoomSearchWidget(),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: FutureBuilder<List<RoomModel>?>(
                            future: futureRoom,
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data!.isEmpty) {
                                return RoomEmptyWidget();
                              } else if (snapshot.hasData &&
                                  snapshot.data!.isNotEmpty) {
                                return RoomDataManegmentWidget(
                                    list: snapshot.data);
                              } else if (snapshot.hasError) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }

                              return FutureLoadingWidget();
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final snackBar = SnackBar(
      content: Text("Erro interno", textAlign: TextAlign.center),
      backgroundColor: Colors.redAccent);

  Future<List<RoomModel>?> fetchRoom() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getStringList('config') != null) {
      List<String> map = sharedPreferences.getStringList('config') ?? [];
      String token = map[0];
      var url = Uri.parse("${dotenv.env["URL"]}/meeting_room");
      http.Response? response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      });

      List<dynamic> listResponse = jsonDecode(response.body);
      List<RoomModel> list = [];
      for (var value in listResponse) {
        list.add(RoomModel.fromJson(value));
      }

      if (response.statusCode == 200) {
        return list;
      } else {
        throw Exception('Failed to load user');
      }
    }
  }
}
