import 'package:flutter/material.dart';
import 'package:meetz/core/core.dart';

class RememberMeWidget extends StatelessWidget {
  final bool rememberMe = false;

  const RememberMeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                //setState(() {
                //rememberMe = value;
                //});
              },
            ),
          ),
          Text(
            'Remember me',
            style: inputLabelStyle,
          ),
        ],
      ),
    );
  }
}
