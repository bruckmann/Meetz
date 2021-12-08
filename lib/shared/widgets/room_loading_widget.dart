import 'package:flutter/material.dart';

class FutureLoadingWidget extends StatelessWidget {
  const FutureLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
