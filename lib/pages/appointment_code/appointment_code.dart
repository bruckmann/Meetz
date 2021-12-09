import 'package:flutter/material.dart';

class AppointmentCodePage extends StatefulWidget {
  final String cod;

  const AppointmentCodePage({Key? key, required this.cod}) : super(key: key);

  @override
  _AppointmentCodePageState createState() => _AppointmentCodePageState();
}

class _AppointmentCodePageState extends State<AppointmentCodePage> {
  @override
  Widget build(BuildContext context) {
    return Text("${widget.cod}");
  }
}
