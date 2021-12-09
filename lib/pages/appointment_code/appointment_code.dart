import 'package:flutter/material.dart';
import 'package:meetz/core/app_colors.dart';
import 'package:meetz/pages/home/home_page.dart';

class AppointmentCodePage extends StatelessWidget {
  final String cod;

  const AppointmentCodePage({Key? key, required this.cod}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    //return Text("${cod}");
    return MaterialApp(
     home: Scaffold(
       appBar: AppBar(
         backgroundColor: AppColors.green600,
       ),
       body: Center(
         child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               
               children: [
                 
                 Text(
                    "SEU CODIGO",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                 Text(
                    "${cod}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  ), ElevatedButton(
                     child: Text('HOME'),                     
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.green600,
                        onPrimary: Colors.black,
                        shadowColor: Colors.black,
                        elevation: 5,
                      ),
                      onPressed: () async {                                                                                         
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                         }
                     )                 
                 /* ElevatedButton(onPressed: () async {                                                                                         
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                }
                              , child: Text("HOME"),
                              style: C,), */
               ],
         ),
       ),

     )
   );
  }
}
/*import 'package:flutter/material.dart';

 void main() {
  runApp(MyApp());
  }

  class MyApp extends StatelessWidget {
  // This widget is the root of your application.
   @override
 Widget build(BuildContext context) {
   
 }
} */