import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(100),
                child: Center(
                  child:
                      Icon(Icons.meeting_room, color: Colors.green, size: 50),
                ),
              ),
              Form(
                child: ),
            ],
          ),
        ));
  }
}
