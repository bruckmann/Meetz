import 'package:flutter/material.dart';
import 'package:meetz/core/app_styles.dart';

class RegisterButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final String text;
  const RegisterButtonWidget(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: buttonCreateRoomStyle,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
