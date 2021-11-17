import 'package:flutter/material.dart';
import 'package:meetz/core/core.dart';
import 'package:meetz/shared/widgets/button_widget.dart';
import 'package:meetz/shared/widgets/input_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

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
                    EdgeInsets.symmetric(horizontal: 40.0, vertical: 100.0),
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
                      label: "Name",
                      placeHolder: "Enter your full name",
                      icon: Icons.person,
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
                    SizedBox(height: 30),
                    InputWidget(
                      label: "Confirm password",
                      placeHolder: "Enter your password",
                      icon: Icons.lock,
                    ),
                    SizedBox(height: 20),
                    //RememberMeWidget(),
                    ButtonWidget(text: 'REGISTER'),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
