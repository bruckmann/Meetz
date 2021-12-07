import 'package:flutter/material.dart';
import 'package:meetz/core/core.dart';

class AdminButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final IconData icon;
  const AdminButtonWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Icon(
            icon,
            color: AppColors.green700,
            size: 40,
          ),
          style: buttonHomeStyle,
        ),
        SizedBox(
          width: 70,
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: AppColors.green700)),
          ),
        )
      ],
    );
  }
}
