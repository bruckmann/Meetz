import 'package:flutter/material.dart';
import 'package:meetz/pages/signup/signup_page.dart';

class SwitchButtonWidget extends StatelessWidget {
  final String text;
  final String textButton;
  final Function() onTap;

  const SwitchButtonWidget({
    Key? key,
    required this.text,
    required this.textButton,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: textButton,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
