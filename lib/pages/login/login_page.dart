import 'package:flutter/material.dart';
import 'package:meetz/core/app_gradients.dart';
import 'package:meetz/pages/login/widgtes/remember_me/remember_me_widget.dart';
import 'package:meetz/pages/login/widgtes/signup_button/signup_button_widget.dart';
import 'package:meetz/shared/widgets/button_widget.dart';
import 'package:meetz/shared/widgets/input_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: AppGradients.linear,
              )),
          Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding:
                    EdgeInsets.symmetric(horizontal: 40.0, vertical: 190.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Meetz",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30.0),
                    InputWidget(
                      label: "Email",
                      placeHolder: "Enter your Email",
                      icon: Icons.email,
                    ),
                    SizedBox(height: 30.0),
                    InputWidget(
                      label: "Password",
                      placeHolder: "Enter your password",
                      icon: Icons.lock,
                    ),
                    SizedBox(height: 20),
                    //RememberMeWidget(),
                    ButtonWidget(text: 'LOGIN'),
                    SignUpButton()
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
