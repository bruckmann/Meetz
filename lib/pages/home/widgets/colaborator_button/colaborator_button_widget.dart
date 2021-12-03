import 'package:flutter/material.dart';
import 'package:meetz/core/core.dart';

class ColaboratorButtonWidget extends StatelessWidget {
  const ColaboratorButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: ElevatedButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.meeting_room, color: AppColors.green700, size: 40),
              Text(
                "Consultar salas",
                style: TextStyle(fontSize: 20, color: AppColors.green700),
              ),
            ],
          ),
          style: buttonHomeStyle,
        ),
      ),
    );
  }
}
