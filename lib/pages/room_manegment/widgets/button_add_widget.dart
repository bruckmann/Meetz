import 'package:flutter/material.dart';
import 'package:meetz/core/core.dart';

class ButtonAddWidget extends StatelessWidget {
  final Function() onPressed;
  const ButtonAddWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            Icons.add,
            color: AppColors.green700,
            size: 20,
          ),
          Text(
            "Adicionar",
            style: TextStyle(color: AppColors.green800),
          ),
        ],
      ),
      style: buttonRoomManegmentStyle,
    );
  }
}
