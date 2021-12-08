import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:meetz/core/app_colors.dart';
import 'package:meetz/core/app_gradients.dart';
import 'package:meetz/pages/home/home_page.dart';
import 'package:meetz/pages/signin/signin_page.dart';
import 'package:meetz/shared/widgets/button_widget.dart';
import 'package:meetz/shared/widgets/input_widget.dart';
import 'package:meetz/shared/widgets/switch_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({Key? key}) : super(key: key);

  @override
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                          "Cadastro",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 30.0),
                        InputWidget(
                            obscureText: false,
                            label: "Nome",
                            placeHolder: "Insira seu nome completo",
                            icon: Icons.person,
                            controller: _nameController,
                            keyboardType: TextInputType.text,
                            validator: (name) {
                              if (name == null || name.isEmpty) {
                                return ("Por favor, insira seu nome");
                              }
                              return null;
                            }),
                        SizedBox(height: 30.0),
                        InputWidget(
                          obscureText: false,
                          label: "E-mail",
                          placeHolder: "Insira seu e-mail",
                          icon: Icons.email,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (email) {
                            if (email == null || email.isEmpty) {
                              return ("Por favor, insira seu e-mail");
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30.0),
                        InputWidget(
                          obscureText: true,
                          label: "Senha",
                          placeHolder: "Insira sua senha",
                          icon: Icons.lock,
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return ("Por favor, insira sua senha");
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        //RememberMeWidget(),
                        ButtonWidget(
                            text: 'CADASTRAR',
                            onPressed: () async {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (_formkey.currentState!.validate()) {
                                var isRight = await signUp();
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                if (isRight) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBarSuccess);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBarError);
                                  _passwordController.clear();
                                }
                              }
                            }),
                        SwitchButtonWidget(
                          text: "Já possui uma conta? ",
                          textButton: "Faça login",
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInPage()));
                          },
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  final snackBarSuccess = SnackBar(
      content:
          Text("Cadastro realizado com sucesso", textAlign: TextAlign.center),
      backgroundColor: AppColors.green600);

  final snackBarError = SnackBar(
      content: Text("E-mail não autorizado", textAlign: TextAlign.center),
      backgroundColor: Colors.redAccent);

  Future<bool> signUp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse("${dotenv.env["URL"]}/user");

    Map data = {
      'user': {
        'name': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'userRole': 'testUser'
      }
    };
    String body = json.encode(data);

    http.Response? response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    Map<String, dynamic> map = jsonDecode(response.body);

    if (response.statusCode == 201) {
      String token = map['token'];
      String id = map['id'].toString();
      await sharedPreferences.setStringList('config', [token, id]);
      return true;
    } else {
      return false;
    }
  }
}
