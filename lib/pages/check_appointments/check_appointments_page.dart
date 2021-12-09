import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meetz/core/app_colors.dart';
import 'package:meetz/core/core.dart';
import 'package:meetz/shared/widgets/empty_appointment_widget.dart';
import 'package:meetz/shared/models/appointment_model.dart';
import 'package:http/http.dart' as http;
import 'package:meetz/shared/models/info_room_model.dart';
import 'package:meetz/shared/widgets/app_bar_back_widget.dart';
import 'package:meetz/shared/widgets/page_title_widget.dart';
import 'package:meetz/shared/widgets/room_loading_widget.dart';
import 'package:meetz/shared/widgets/room_search_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CheckAppointmentsPage extends StatefulWidget {
  const CheckAppointmentsPage({Key? key}) : super(key: key);

  @override
  _CheckAppointmentsPageState createState() => _CheckAppointmentsPageState();
}

class _CheckAppointmentsPageState extends State<CheckAppointmentsPage> {
  late Future<List<AppointmentModel>?> futureAppointment;
  late Future<InfoRoomModel?> futureRoom;
  late int id_room;

  @override
  void initState() {
    super.initState();
    futureAppointment = fetchAppointment();
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
                PageTitleWidget(title: "Agendamentos"),
                Column(
                  children: [
                    RoomSearchWidget(),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: FutureBuilder<List<AppointmentModel>?>(
                          future: futureAppointment,
                          builder: (context, snapshot) {
                            if (snapshot.data == null ||
                                snapshot.data!.isEmpty) {
                              return EmptyAppointmentsWidget();
                            } else if (snapshot.hasData &&
                                snapshot.data!.isNotEmpty) {
                              return SingleChildScrollView(
                                child: Container(
                                  height: 500,
                                  child: ListView.separated(
                                    primary: false,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      id_room =
                                          snapshot.data![index].meeting_room_id;
                                      return FutureBuilder<InfoRoomModel?>(
                                          future: fetchRoom(id_room),
                                          builder: (context, room) {
                                            if (room.hasData &&
                                                room.data != null) {
                                              return Container(
                                                height: 130,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 6.0,
                                                      offset: Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          "Sala ${room.data!.name} - ${snapshot.data![index].day}/${snapshot.data![index].month}/${snapshot.data![index].year}",
                                                          style:
                                                              infoRoomTextStyle),
                                                      SizedBox(height: 20),
                                                      Text(
                                                          "Horário: ${snapshot.data![index].initial_hour}:${snapshot.data![index].end_hour}"),
                                                      Text(
                                                        "Observação: ${snapshot.data![index].note}",
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                            return FutureLoadingWidget();
                                          });
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const Divider(
                                                color: Colors.transparent),
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }

                            return FutureLoadingWidget();
                          }),
                    ),
                  ],
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

  Future<List<AppointmentModel>?> fetchAppointment() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getStringList('config') != null) {
      List<String> map = sharedPreferences.getStringList('config') ?? [];
      String token = map[0];
      String id = map[1].toString();

      var url = Uri.parse(
          "${dotenv.env["URL"]}/appointment/user_appointments?user_id=${id}&type=tree_last");
      http.Response? response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      });

      List<dynamic> listResponse = jsonDecode(response.body);
      List<AppointmentModel> list = [];

      int appointment_id;
      int meeting_room_id;
      String date;
      String hour;
      String date_final;
      String month;
      String day;
      String year;
      String initial_hour;
      String end_hour;

      for (var value in listResponse) {
        date = value['initial_date'];
        date_final = value['end_date'];

        initial_hour = date.split("T")[1].substring(0, 5);
        end_hour = date_final.split("T")[1].substring(0, 5);

        date = date.split("T")[0];
        year = date.split("-")[0];
        month = date.split("-")[1];
        day = date.split("-")[2];
        switch (month) {
          case "1":
            month = "Janeiro";
            break;
          case "2":
            month = "Fevereiro";
            break;
          case "3":
            month = "Março";
            break;
          case "4":
            month = "Abril";
            break;
          case "5":
            month = "Maio";
            break;
          case "6":
            month = "Junho";
            break;
          case "7":
            month = "Julho";
            break;
          case "8":
            month = "Agosto";
            break;
          case "9":
            month = "Setembro";
            break;
          case "10":
            month = "Outubro";
            break;
          case "11":
            month = "Novembro";
            break;
          case "12":
            month = "Dezembro";
            break;
          default:
        }
        list.add(AppointmentModel(
          year: year,
          month: month,
          day: day,
          note: value['note'],
          end_hour: end_hour,
          initial_hour: initial_hour,
          appointment_id: value['id'],
          meeting_room_id: value['meeting_room_id'],
        ));
      }

      if (response.statusCode == 200) {
        return list;
      } else {
        throw Exception('Failed to load appointments');
      }
    }
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

      InfoRoomModel? list = InfoRoomModel.fromJson(infoRoomResponse);

      if (response.statusCode == 200) {
        return list;
      } else {
        throw Exception('Failed to load user');
      }
    }
  }
}
