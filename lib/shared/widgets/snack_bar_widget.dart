import 'package:flutter/material.dart';

class SnackBarWidget extends StatelessWidget {
  final String message;
  final Color color;
  const SnackBarWidget({
    Key? key,
    required this.message,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        backgroundColor: color);
  }
}
