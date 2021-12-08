import 'package:flutter/material.dart';
import 'package:meetz/core/core.dart';

final inputHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final inputLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final inputBoxDecorationStyle = BoxDecoration(
  color: AppColors.green800,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final buttonHomeStyle = ButtonStyle(
    elevation: MaterialStateProperty.all<double>(5.0),
    shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.00))),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(horizontal: 30.00, vertical: 20)));

final roomTextDecorationStyle = TextStyle(
  color: AppColors.green800,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final roomTitleDecorationStyle = TextStyle(
    color: AppColors.green800,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
    fontSize: 30);

final buttonRoomManegmentStyle = ButtonStyle(
    elevation: MaterialStateProperty.all<double>(0),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(horizontal: 20.00, vertical: 20)));

final buttonCreateRoomStyle = ButtonStyle(
    elevation: MaterialStateProperty.all<double>(5.0),
    shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.00))),
    backgroundColor: MaterialStateProperty.all<Color>(AppColors.green800),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(horizontal: 30.00, vertical: 20)));
