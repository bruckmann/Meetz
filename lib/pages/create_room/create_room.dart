
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meetz/core/app_gradients.dart';
import 'package:meetz/pages/home/home_page.dart';
import 'package:meetz/pages/create_room/widgets/input/input_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'widgets/button/button_widget.dart';

class CreateRoomPage extends StatefulWidget {
  const CreateRoomPage({ Key? key }) : super(key: key);

  @override
  _CreateRoomPageState createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  final _formkey = GlobalKey<FormState>();
  final _imageController = TextEditingController();
  final _maxPeopleController = TextEditingController();
  final _roomNumberController = TextEditingController();
  final _floorNumberController = TextEditingController();
  final _roomNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _metersRoomController = TextEditingController();

  bool _hasSplit = false;
  bool _hasBoard= false;
  bool _hasDatashow = false;

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
                          "Cadastro de salas",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 30.0),
                         InputWidget(
                          obscureText: false,
                          label: "Nome da sala",
                          placeHolder: "Insira o nome da sala",
                          icon: Icons.text_format,
                          controller: _roomNameController,
                          keyboardType: TextInputType.number,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return ("Por favor, insira o nome da sala");
                            }
                            return null;
                          },
                        ),
                      SizedBox(height: 30.0),
                        InputWidget(
                          obscureText: false,
                          label: "Imagem",
                          placeHolder: "Insira a imagem da sala",
                          icon: Icons.image,
                          controller: _imageController,
                          keyboardType: TextInputType.text,
                          validator: (name){
                            if (name == null || name.isEmpty){
                              return ("Por favor, insira a imagem");
                            }
                            return null;
                          }

                        ),
                        SizedBox(height: 30.0),
                       InputWidget(
                          obscureText: false,
                          label: "Maximo de pessoas",
                          placeHolder: "Insira o maximo de pessoas que podem caber na sala",
                          icon: Icons.people,
                          controller: _maxPeopleController,
                          keyboardType: TextInputType.number,
                          validator: (email) {
                            if (email == null || email.isEmpty) {
                              return ("Por favor, insira o maximo de pessoas");
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30.0),
                         InputWidget(
                          obscureText: false,
                          label: "Numero da sala",
                          placeHolder: "Insira o numero da sala",
                          icon: Icons.format_list_numbered_rtl_rounded,
                          controller: _roomNumberController,
                          keyboardType: TextInputType.number,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return ("Por favor, insira o numero da sala");
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30.0),
                        InputWidget(
                          obscureText: false,
                          label: "Numero do andar",
                          placeHolder: "Insira o numero do andar",
                          icon: Icons.format_list_numbered_rtl_rounded,
                          controller: _floorNumberController,
                          keyboardType: TextInputType.number,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return ("Por favor, insira o numero do andar");
                            }
                            return null;
                          },
                        ),
                        
                        SizedBox(height: 30.0),
                         InputWidget(
                          obscureText: false,
                          label: "Descrição",
                          placeHolder: "Insira a descrição da sala",
                          icon: Icons.text_fields,
                          controller: _descriptionController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return ("Por favor, insira a descrição");
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30.0),
                         InputWidget(
                          obscureText: false,
                          label: "Metros da sala",
                          placeHolder: "Insira o numero de metros da sala",
                          icon: Icons.meeting_room_sharp,
                          controller: _metersRoomController,
                          keyboardType: TextInputType.number,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return ("Por favor, insira o numero de metros da sala");
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30.0),
                          SwitchListTile(
                            title: const Text('Possui ar-condicionado'),
                            
                            value: _hasSplit,
                            onChanged: (bool value) {
                             setState(() {
                            _hasSplit = value;
                            });
                            },
                            secondary: const Icon(Icons.checklist_rtl_rounded)
                          ), 
                          SwitchListTile(
                            title: const Text('Possui quadro'),
                            value: _hasBoard,
                            onChanged: (bool value) {
                             setState(() {
                            _hasBoard = value;
                            });
                            },
                            secondary: const Icon(Icons.checklist_rtl_rounded)
                          ),
                          SwitchListTile(
                            title: const Text('Possui Datashow'),
                            value: _hasDatashow,
                            onChanged: (bool value) {
                             setState(() {
                            _hasDatashow = value;
                            });
                            },
                            secondary: const Icon(Icons.checklist_rtl_rounded)
                          ),
                        SizedBox(height: 30),
                        //RememberMeWidget(),
                        RegisterButtonWidget(
                            text: 'CADASTRAR SALA',
                            onPressed: () async {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (_formkey.currentState!.validate()) {
                               var response = await create_room();
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                print(response);
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

  Future<bool?> create_room() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getStringList('config') != null) {
    List<String> map = sharedPreferences.getStringList('config') ?? [];
    String token = map[0];
    var url = Uri.parse("${dotenv.env["URL"]}/meeting_room");

    Map data = {
    'room_specification' : {
        'name': _roomNameController.text,
        'description': _descriptionController.text,
        'max_person': _maxPeopleController.text,
        'has_data_show': _hasDatashow.toString(),
        'has_board': _hasBoard.toString(),
        'has_split': _hasSplit.toString(),
        'size': _metersRoomController.text 
    },
    'room_localization': {
        'number': _roomNumberController.text,
        'floor': _floorNumberController.text
    },
    'images': {
      'url': _imageController.text
    }
      
  }; 
    String body = json.encode(data);

    http.Response? response = await http.post(url,
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
        body: body});
        
    if (response.statusCode == 201) {      
      return true;
    } else {
      return false;
      } 
    }
  }
}
