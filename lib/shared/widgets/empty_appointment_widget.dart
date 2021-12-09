import 'package:flutter/material.dart';

class EmptyAppointmentsWidget extends StatelessWidget {
  const EmptyAppointmentsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Você ainda não possui agendamentos");
  }
}
