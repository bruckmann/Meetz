import 'package:flutter/material.dart';
import 'package:meetz/core/app_colors.dart';
import 'package:meetz/core/core.dart';
import 'package:meetz/pages/home/home_page.dart';
import 'package:meetz/shared/widgets/button_widget.dart';
import 'package:meetz/shared/widgets/form_button_widget.dart';

class AppointmentCodePage extends StatelessWidget {
  final String cod;

  const AppointmentCodePage({Key? key, required this.cod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return Text("${cod}");
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Sua sala foi reservada com sucesso, aqui está seu código!",
                  style: titleDecorationStyle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "CÓDIGO: ${cod}",
                  style: TextStyle(
                      color: AppColors.green600,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
                FormButtonWidget(
                    text: "VOLTAR PARA HOME",
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
