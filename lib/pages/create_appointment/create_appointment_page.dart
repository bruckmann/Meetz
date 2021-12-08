import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meetz/core/app_gradients.dart';
import 'package:meetz/pages/home/home_page.dart';
import 'package:meetz/pages/create_appointment/widgets/input/input_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'widgets/button/button_widget.dart';

class CreateAppointmentPage extends StatefulWidget {
  final int id_room;
  const CreateAppointmentPage({Key? key, required this.id_room})
      : super(key: key);

  @override
  _CreateAppointmentPageState createState() => _CreateAppointmentPageState();
}

class _CreateAppointmentPageState extends State<CreateAppointmentPage> {
  final _formkey = GlobalKey<FormState>();
  final _initial_dateController = TextEditingController();
  final _end_dateController = TextEditingController();
  final _initial_hourController = TextEditingController();
  final _end_hourController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: AppGradients.linear,
                )),
            Form(
                key: _formkey,
                child: Center(
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Agendamento",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 30.0),
                        /*   IconButton(
                          icon: Icon(Icons.date_range),
                          onPressed: () async{
                             _initial_dateController = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2023),
                              locale: Locale("pt", "BR"),
                                );
                        }
                         ), CAIXA DE DATAS*/

                        InputWidget(
                          obscureText: false,
                          label: "Data de inicio",
                          placeHolder: "Insira a data de inicio do agendamento",
                          icon: Icons.text_format,
                          controller: _initial_dateController,
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ("Por favor, insira a data do agendamento");
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30.0),
                        InputWidget(
                            obscureText: false,
                            label: "Data do encerramento",
                            placeHolder: "Insira a data do encerramento",
                            icon: Icons.image,
                            controller: _end_dateController,
                            keyboardType: TextInputType.datetime,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ("Por favor, insira a data do encerramento");
                              }
                              return null;
                            }),
                        InputWidget(
                          obscureText: false,
                          label: "Hora de inicio",
                          placeHolder: "Insira a hora de inicio do agendamento",
                          icon: Icons.text_format,
                          controller: _initial_hourController,
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ("Por favor, insira a hora do agendamento");
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30.0),
                        InputWidget(
                            obscureText: false,
                            label: "Hora do encerramento",
                            placeHolder: "Insira a hora do encerramento",
                            icon: Icons.image,
                            controller: _end_hourController,
                            keyboardType: TextInputType.datetime,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ("Por favor, insira a hora do encerramento");
                              }
                              return null;
                            }),
                        SizedBox(height: 30.0),
                        InputWidget(
                          obscureText: false,
                          label: "Nota",
                          placeHolder: "Insira uma nota",
                          icon: Icons.people,
                          controller: _noteController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ("Por favor, insira uma nota");
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        //RememberMeWidget(),
                        RegisterButtonWidget(
                            text: 'AGENDAR',
                            onPressed: () async {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (_formkey.currentState!.validate()) {
                                var response =
                                    await createAppointment(widget.id_room);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                if (response == true) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            })
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  final snackBar = SnackBar(
      content: Text("Algum campo invalido", textAlign: TextAlign.center),
      backgroundColor: Colors.redAccent);

  Future<bool?> createAppointment(int id_room) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getStringList('config') != null) {
      List<String> map = sharedPreferences.getStringList('config') ?? [];
      String token = map[0];
      String id = map[1];
      var url = Uri.parse("${dotenv.env["URL"]}/appointment");

      String initialDate =
          "${_initial_dateController.text}T${_initial_hourController.text}";
      String endDate =
          "${_end_dateController.text}T${_end_hourController.text}";

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

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        String token = map['token'];
        String id = map['id'].toString();

        await sharedPreferences.setStringList('appointment', [token, id]);
        return true;
      } else {
        return false;
      }
    }
  }
}
