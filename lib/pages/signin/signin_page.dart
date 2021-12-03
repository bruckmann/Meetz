import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meetz/core/core.dart';
import 'package:meetz/pages/home/home_page.dart';
import 'package:meetz/pages/signin/widgtes/input/input_widget.dart';
import 'package:meetz/pages/signin/widgtes/signin_button/signin_button_widget.dart';
//import 'package:meetz/pages/signin/widgtes/remember_me/remember_me_widget.dart';
import 'package:meetz/pages/signin/widgtes/signup_button/signup_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formkey = GlobalKey<FormState>();
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
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
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
                        SizedBox(height: 20),
                        //RememberMeWidget(),
                        SignInButtonWidget(
                            text: 'LOGIN',
                            onPressed: () async {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (_formkey.currentState!.validate()) {
                                var isRight = await signin();
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
                            }),
                        SignUpButtonWidget()
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
      content: Text("E-mail or password invalid!", textAlign: TextAlign.center),
      backgroundColor: Colors.redAccent);

  Future<bool> signin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse("http://18.212.61.159/login");
    Map data = {
      'email': _emailController.text,
      'password': _passwordController.text,
    };
    String body = json.encode(data);

    http.Response? response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    if (response.statusCode == 200) {
      await sharedPreferences.setString(
          'token', "${jsonDecode(response.body)['token']}");
      return true;
    } else {
      return false;
    }
  }
}
