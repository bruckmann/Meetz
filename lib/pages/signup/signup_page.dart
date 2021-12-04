
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meetz/core/app_gradients.dart';
import 'package:meetz/pages/home/home_page.dart';
import 'package:meetz/pages/signup/widgets/input/input_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'widgets/button/button_widget.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({ Key? key }) : super(key: key);

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
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 30.0),
                        InputWidget(
                          obscureText: false,
                          label: "Name",
                          placeHolder: "Enter your full name",
                          icon: Icons.person,
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                          validator: (name){
                            if (name == null || name.isEmpty){
                              return ("Please, entrer your name");
                            }
                            return null;
                          }

                        ),
                        SizedBox(height: 30.0),
                       InputWidget(
                          obscureText: false,
                          label: "Email",
                          placeHolder: "Enter your Email",
                          icon: Icons.email,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (email) {
                            if (email == null || email.isEmpty) {
                              return ("Please, enter your E-mail");
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30.0),
                         InputWidget(
                          obscureText: true,
                          label: "Password",
                          placeHolder: "Enter your password",
                          icon: Icons.lock,
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return ("Please, enter your password");
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        //RememberMeWidget(),
                        RegisterButtonWidget(
                            text: 'REGISTER',
                            onPressed: () async {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (_formkey.currentState!.validate()) {
                                var isRight = await signup();
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                if (isRight) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                } else {
                                  _passwordController.clear();
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

  Future<bool> signup() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse("http://localhost:3000/user");

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
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}