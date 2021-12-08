import 'package:flutter/material.dart';
import 'package:meetz/core/core.dart';

class CheckAppointmentsWidget extends StatelessWidget {
  const CheckAppointmentsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: buttonNoStyle,
      onPressed: () {},
      child: Row(
        children: [
          Text(
            "Consultar",
            style: TextStyle(color: AppColors.green800),
          ),
          Icon(
            Icons.keyboard_arrow_right,
            color: AppColors.green800,
          ),
        ],
      ),
    );
  }
}
