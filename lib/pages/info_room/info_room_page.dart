import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meetz/core/core.dart';
import 'package:meetz/pages/create_appointment/create_appointment_page.dart';
import 'package:meetz/pages/rooms/list_rooms_page.dart';
import 'package:meetz/pages/rooms_manegment/room_manegment_page.dart';
import 'package:meetz/pages/update_room/update_room.dart';
import 'package:meetz/shared/models/info_room_model.dart';
import 'package:meetz/shared/widgets/app_bar_back_widget.dart';
import 'package:meetz/shared/widgets/page_title_widget.dart';
import 'package:meetz/shared/widgets/room_loading_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class InfoRoomPage extends StatefulWidget {
  final int id_room;
  final bool isManegment;

  const InfoRoomPage({
    Key? key,
    required this.id_room,
    required this.isManegment,
  }) : super(key: key);

  @override
  _InfoRoomPageState createState() => _InfoRoomPageState();
}

class _InfoRoomPageState extends State<InfoRoomPage> {
  late Future<InfoRoomModel?> futureRoom;

  @override
  void initState() {
    super.initState();
    futureRoom = fetchRoom(widget.id_room);
  }

  @override
  Widget build(BuildContext context) {
    deleteRoom();
    return SafeArea(
      child: Scaffold(
          appBar: AppBarBackWidget(
            onPressed: () {
              widget.isManegment
                  ? Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoomsManegmentPage(),
                      ),
                    )
                  : Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoomsPage(),
                      ));
            },
          ),
          body: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 40,
              ),
              child: FutureBuilder<InfoRoomModel?>(
                  future: futureRoom,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PageTitleWidget(title: snapshot.data!.name),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                snapshot.data!.image_url,
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Sala: Número ${snapshot.data!.number} - ${snapshot.data!.floor}º andar",
                              style: infoRoomTextStyle,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Descrição: ${snapshot.data!.description}",
                              style: infoRoomTextStyle,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Especificações:",
                              style: infoRoomTextStyle,
                            ),
                            Row(
                              children: [
                                Icon(Icons.square_foot),
                                SizedBox(width: 10),
                                Text(
                                  "${snapshot.data!.size}",
                                  style: infoRoomTextStyle,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.group),
                                SizedBox(width: 10),
                                Text(
                                  "Max: ${snapshot.data!.max_person} pessoas",
                                  style: infoRoomTextStyle,
                                )
                              ],
                            ),
                            snapshot.data!.has_split == true
                                ? Row(
                                    children: [
                                      Icon(Icons.air),
                                      SizedBox(width: 10),
                                      Text(
                                        "Possui ar condicionado",
                                        style: infoRoomTextStyle,
                                      )
                                    ],
                                  )
                                : Container(),
                            snapshot.data!.has_board == true
                                ? Row(
                                    children: [
                                      Icon(Icons.check_box_outline_blank),
                                      SizedBox(width: 10),
                                      Text(
                                        "Possui quadro",
                                        style: infoRoomTextStyle,
                                      )
                                    ],
                                  )
                                : Container(),
                            snapshot.data!.has_data_show == true
                                ? Row(
                                    children: [
                                      Icon(Icons.camera_outdoor),
                                      SizedBox(width: 10),
                                      Text(
                                        "Possui datashow",
                                        style: infoRoomTextStyle,
                                      )
                                    ],
                                  )
                                : Container(),
                            SizedBox(
                              height: 20,
                            ),
                            widget.isManegment
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () => showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    title: Text(
                                                        "Você deseja deletar esta sala ?"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Text(
                                                          "Não",
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .green800),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          await deleteRoom();
                                                          Navigator
                                                              .pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  RoomsManegmentPage(),
                                                            ),
                                                          );
                                                        },
                                                        child: Text(
                                                          "Sim",
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .green800),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                          style: buttonRedStyle,
                                          child: Text("REMOVER",
                                              style: TextButtonStyle),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateRoomPage(
                                                          id_room:
                                                              widget.id_room,
                                                        )));
                                          },
                                          style: buttonGreenStyle,
                                          child: Row(
                                            children: [
                                              Icon(Icons.edit),
                                              Text(" EDITAR",
                                                  style: TextButtonStyle),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CreateAppointmentPage(
                                                      room: snapshot.data,
                                                      id_room: widget.id_room,
                                                    )));
                                      },
                                      style: buttonGreenStyle,
                                      child: Text("AGENDAR SALA",
                                          style: TextButtonStyle),
                                    ),
                                  ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    return FutureLoadingWidget();
                  }),
            ),
          )),
    );
  }

  final snackBar = SnackBar(
      content: Text("Erro interno", textAlign: TextAlign.center),
      backgroundColor: Colors.redAccent);

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

      InfoRoomModel? list = InfoRoomModel.fromJson(infoRoomResponse);

      if (response.statusCode == 200) {
        return list;
      } else {
        throw Exception('Failed to load user');
      }
    }
  }

  Future<bool> deleteRoom() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> map = sharedPreferences.getStringList('config') ?? [];
    String token = map[0];

    var url = Uri.parse("${dotenv.env["URL"]}/meeting_room/${widget.id_room}");

    http.Response? response = await http.delete(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
