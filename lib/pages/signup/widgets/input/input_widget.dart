import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meetz/core/core.dart';

class InputWidget extends StatelessWidget {
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?) validator;
  final String label;
  final String placeHolder;
  final IconData icon;
  
  const InputWidget({
    Key? key,
    required this.label,
    required this.placeHolder,
    required this.icon, 
    required this.obscureText,
    required this.controller, 
    required this.keyboardType, 
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: inputLabelStyle),
        SizedBox(height: 10),
        Container(
            alignment: Alignment.centerLeft,
            decoration: inputBoxDecorationStyle,
            height: 60.0,
            child: (TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              validator: validator,
              style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
              decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10.0),
                  prefixIcon: Icon(icon, color: Colors.white),
                  hintText: placeHolder,
                  hintStyle: inputHintTextStyle),
            )))
      ],
    );
  }
}
