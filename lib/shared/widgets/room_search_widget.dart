import 'package:flutter/material.dart';
import 'package:meetz/core/core.dart';

class RoomSearchWidget extends StatelessWidget {
  const RoomSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            onChanged: (value) {},
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.green800)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.green800)),
              hintText: "Pesquisar",
              hintStyle: TextStyle(
                color: Colors.black26,
              ),
            ),
          ),
        ),
        Icon(Icons.search, color: AppColors.green800)
      ],
    );
  }
}
