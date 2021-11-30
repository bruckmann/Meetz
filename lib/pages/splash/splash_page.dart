import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meetz/core/core.dart';
import 'package:meetz/pages/welcome/welcome_page.dart';
import 'package:page_transition/page_transition.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppGradients.linear),
      child: AnimatedSplashScreen(
        splash: SvgPicture.asset(
          'assets/images/white_logo.svg',
          fit: BoxFit.cover,
          width: 250,
          height: 250,
        ),
        nextScreen: (WelcomePage()),
        splashTransition: SplashTransition.slideTransition,
        pageTransitionType: PageTransitionType.bottomToTop,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
