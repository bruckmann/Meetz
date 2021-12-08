import 'package:flutter/material.dart';
import 'package:meetz/core/core.dart';

class PageTitleWidget extends StatelessWidget {
  final String title;
  const PageTitleWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          title,
          style: roomTitleDecorationStyle,
          textAlign: TextAlign.left,
        ));
  }
}
