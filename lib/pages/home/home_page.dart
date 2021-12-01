import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meetz/core/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(color: AppColors.green600),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Welcome, Jardel!",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            width: 300,
                            child: Text(
                              "You have a meeting scheduled for November 12, 2021 at 3:00 pm.",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notification_important,
                          color: Colors.white,
                          size: 24,
                        ),
                        alignment: Alignment.center,
                      )
                    ],
                  ),
                )),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Consultar salas disponíveis",
                style: TextStyle(fontSize: 24),
              ),
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(5.0),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.00))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.green500),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 20.00, vertical: 30))),
            ),
            SvgPicture.asset(
              'assets/images/green_logo.svg',
              fit: BoxFit.cover,
              width: 50,
              height: 50,
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
