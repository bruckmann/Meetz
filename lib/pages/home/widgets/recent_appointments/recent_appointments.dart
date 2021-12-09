import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meetz/core/app_colors.dart';
import 'package:meetz/core/core.dart';
//import 'package:meetz/pages/home/widgets/empty_appointment/empty_appointment_widget.dart';
import 'package:meetz/shared/models/appointment_model.dart';
import 'package:http/http.dart' as http;
import 'package:meetz/shared/widgets/empty_appointment_widget.dart';
import 'package:meetz/shared/widgets/room_loading_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RecentAppointmentsWidget extends StatefulWidget {
  const RecentAppointmentsWidget({Key? key}) : super(key: key);

  @override
  _RecentAppointmentsWidgetState createState() =>
      _RecentAppointmentsWidgetState();
}

class _RecentAppointmentsWidgetState extends State<RecentAppointmentsWidget> {
  late Future<List<AppointmentModel>?> futureAppointment;

  @override
  void initState() {
    super.initState();
    futureAppointment = fetchAppointment();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AppointmentModel>?>(
        future: futureAppointment,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isEmpty) {
            return EmptyAppointmentsWidget();
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return RichText(
                  text: TextSpan(
                    text: 'Você possui um agendamento marcado para dia ',
                    style: TextStyle(
                        color: AppColors.green700,
                        fontFamily: "OpenSans",
                        fontSize: 15),
                    children: <TextSpan>[
                      TextSpan(
                          text: '${snapshot.data![index].day}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ' de '),
                      TextSpan(
                          text: '${snapshot.data![index].month}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ' de '),
                      TextSpan(
                          text: '${snapshot.data![index].year}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ' das '),
                      TextSpan(
                          text: '${snapshot.data![index].initial_hour}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ' às '),
                      TextSpan(
                          text: '${snapshot.data![index].end_hour}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: '.'),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(color: Colors.transparent),
            );
          } else if (snapshot.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

          return FutureLoadingWidget();
        });
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
}
