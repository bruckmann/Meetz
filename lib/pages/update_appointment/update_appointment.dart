/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meetz/core/core.dart';
import 'package:meetz/pages/info_room/info_room_page.dart';

import 'package:meetz/shared/models/appointment_model.dart';

import 'package:meetz/shared/widgets/app_bar_back_widget.dart';
import 'package:meetz/shared/widgets/form_button_widget.dart';
import 'package:meetz/shared/widgets/form_input_widget.dart';
import 'package:meetz/shared/widgets/page_title_widget.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:date_time_picker/date_time_picker.dart';

class UpdateAppointmentPage extends StatefulWidget {
  final int id_room;
  const UpdateAppointmentPage({Key? key, required this.id_room}) : super(key: key);

  @override
  _UpdateAppointmentPageState createState() => _UpdateAppointmentPageState();
}

class _UpdateAppointmentPageState extends State<UpdateAppointmentPage> {
  final _formkey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _initial_hourController = TextEditingController();
  final _end_hourController = TextEditingController();
  final _noteController = TextEditingController();
  

  late Future<AppointmentModel?> futureRoom;

  @override
  void initState() {
    super.initState();
    futureRoom = fetchAppointment()
      ..then((result) {
        setState(() {
          AppointmentModel? roomValues = result;
          _dateController.text = "${roomValues!.day}";
          _initial_hourController.text = "${roomValues.initial_hour}";
          _end_hourController.text = "${roomValues.end_hour}";
          _noteController.text = "${roomValues.note}";  
        });
      });
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
                builder: (context) => InfoRoomPage(
                  id_room: widget.id_room,
                  isManegment: false,
                ),
              ),
            );
          },
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 40,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageTitleWidget(title: "Agendar sala"),
                Row(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      widget.room!.image_url,
                      width: 180,
                      height: 120,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('${widget.room!.name}',
                              style: roomTitleDecorationStyle),
                          Text(
                              "Sala: ${widget.room!.number} - ${widget.room!.floor}º andar",
                              style: roomTextDecorationStyle),
                          Text("Descrição: ${widget.room!.description}",
                              style: roomTextDecorationStyle),
                        ],
                      ),
                    ),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Form(
                      key: _formkey,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DateTimePicker(
                              type: DateTimePickerType.date,
                              dateMask: 'd MMM, yyyy',
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              icon: Icon(Icons.event),
                              dateLabelText: 'Data',
                              controller: _dateController,
                              selectableDayPredicate: (date) {
                                if (date.weekday == 6 || date.weekday == 7) {
                                  return false;
                                }
                                return true;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return ("Por favor, insira o horário de inicio");
                                }
                                return null;
                              },
                            ),

                            DateTimePicker(
                              type: DateTimePickerType.time,
                              icon: Icon(Icons.watch_later_outlined),
                              timeLabelText: "Horário de inicio",
                              controller: _initial_hourController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return ("Por favor, insira o horário de inicio");
                                }

                                int hour = int.parse(value.split(":")[0]);
                                int minute = int.parse(value.split(":")[1]);

                                if (hour < 06 || hour > 18) {
                                  return "Por favor, insira um horário válido";
                                } else if (minute != 00 && minute != 30) {
                                  return "Por favor, insira um horário válido";
                                }
                                return null;
                              },
                            ),
                            DateTimePicker(
                              type: DateTimePickerType.time,
                              icon: Icon(Icons.watch_later),
                              timeLabelText: "Hora de encerramento",
                              controller: _end_hourController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return ("Por favor, insira o horário de inicio");
                                }

                                int hour = int.parse(value.split(":")[0]);
                                int minute = int.parse(value.split(":")[1]);

                                if (hour < 06 || hour > 18) {
                                  return "Por favor, insira um horário válido";
                                } else if (minute != 00 && minute != 30) {
                                  return "Por favor, insira um horário válido";
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                  "Aceitamos agendamento apenas em horário comercial (6:00 às 18:00) e de 30 em 30 minutos",
                                  style: TextStyle(fontSize: 8)),
                            ),
                            FormInputWidget(
                              label: "Observações",
                              icon: Icons.rtt,
                              controller: _noteController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return ("Por favor, insira uma observação");
                                }
                                return null;
                              },
                            ),
                            //RememberMeWidget(),
                            FormButtonWidget(
                                text: 'AGENDAR',
                                onPressed: () async {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (_formkey.currentState!.validate()) {
                                    List? response =
                                        await createAppointment(widget.id_room);

                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                    if (response![0] == "success") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Agendamento feito com sucesso",
                                                  textAlign: TextAlign.center),
                                              backgroundColor:
                                                  AppColors.green600));
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AppointmentCodePage(
                                                      cod: response[1])));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(response[1],
                                                  textAlign: TextAlign.center),
                                              backgroundColor:
                                                  Colors.redAccent));
                                    }
                                  }
                                })
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List?> createAppointment(int id_room) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getStringList('config') != null) {
      List<String> map = sharedPreferences.getStringList('config') ?? [];
      String token = map[0];
      String id = map[1];
      var url = Uri.parse("${dotenv.env["URL"]}/appointment");

      String dateFormatter = _dateController.text.split(" ")[0];
      String year = dateFormatter.split("-")[0];
      String month = dateFormatter.split("-")[1];
      String day = dateFormatter.split("-")[2];
      dateFormatter = "${day}/${month}/${year}";

      String initialDate = "${dateFormatter}T${_initial_hourController.text}";
      String endDate = "${dateFormatter}T${_end_hourController.text}";

      Map data = {
        "meeting_room_id": id_room,
        "user_id": id,
        "initial_date": initialDate,
        "end_date": endDate,
        "note": _noteController.text,
      };
      String body = json.encode(data);

      http.Response? response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: body);

      Map<String, dynamic> list = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List res = ["success", list['id'].toString()];
        return res;
      } else {
        List res = ["error", list['error'].toString()];
        return res;
      }
    }
  }

  Future<AppointmentModel?> fetchAppointment() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getStringList('config') != null) {
      List<String> map = sharedPreferences.getStringList('config') ?? [];
      String token = map[0];

      var url =
          Uri.parse("${dotenv.env["URL"]}/appointment/${widget.id_room}");
      http.Response? response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        return AppointmentModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load user');
      }
    }
  }
}
*/