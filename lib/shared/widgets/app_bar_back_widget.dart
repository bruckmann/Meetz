import 'package:flutter/material.dart';
import 'package:meetz/core/core.dart';
import 'package:meetz/pages/home/home_page.dart';

class AppBarBackWidget extends StatelessWidget with PreferredSizeWidget {
  final Function()? onPressed;

  @override
  final Size preferredSize;

  AppBarBackWidget({Key? key, this.onPressed})
      : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: onPressed ??
            () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
        icon: Icon(
          Icons.arrow_back,
          color: AppColors.green800,
        ),
      ),
    );
  }
}
