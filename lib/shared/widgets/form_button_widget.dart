import 'package:flutter/material.dart';
import 'package:meetz/core/app_styles.dart';

class FormButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final String text;
  const FormButtonWidget(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: buttonGreenStyle,
        child: Text(text, style: TextButtonStyle),
      ),
    );
  }
}
