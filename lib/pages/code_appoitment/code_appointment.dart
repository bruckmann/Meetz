import 'package:flutter/material.dart';

class CodeAppointmentPage extends StatefulWidget {
  final String cod;

  const CodeAppointmentPage({Key? key, required this.cod}) : super(key: key);

  @override
  _CodeAppointmentPageState createState() => _CodeAppointmentPageState();
}

class _CodeAppointmentPageState extends State<CodeAppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return Text("${widget.cod}");
  }
}
