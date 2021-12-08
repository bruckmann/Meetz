import 'package:flutter/material.dart';

class RoomEmptyWidget extends StatelessWidget {
  const RoomEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Ainda não possui salas cadastradas no sistema");
  }
}
