import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meetz/core/core.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?) validator;
  final String label;
  final IconData icon;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;

  const InputWidget(
      {Key? key,
      required this.label,
      required this.icon,
      required this.controller,
      required this.keyboardType,
      required this.validator,
      this.inputFormatters,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        inputFormatters: [],
        maxLines: maxLines,
        style: TextStyle(color: AppColors.green800, fontFamily: 'OpenSans'),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColors.green800),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.green800)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.green900)),
          hintText: label,
          hintStyle: TextStyle(
            color: Colors.black26,
          ),
        ),
      ),
    );
  }
}
