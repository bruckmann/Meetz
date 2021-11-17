import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:meetz/core/app_colors.dart';
import 'package:meetz/pages/signin/signin_page.dart';
//import 'package:meetz/home/home_page.dart';
import 'package:page_transition/page_transition.dart';

class SplashPage extends StatelessWidget{
  const SplashPage({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return AnimatedSplashScreen(
      splash: Image.asset('images/rui.jpeg'),
      nextScreen: (SignInPage()),
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.bottomToTop,
      backgroundColor: AppColors.green600,
    );
  }
}