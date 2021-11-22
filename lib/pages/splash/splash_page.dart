import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:meetz/core/core.dart';
import 'package:meetz/pages/signin/signin_page.dart';
import 'package:page_transition/page_transition.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppGradients.linear),
      child: AnimatedSplashScreen(
        splash: Image.asset('assets/images/rui.jpeg'),
        nextScreen: (SignInPage()),
        splashTransition: SplashTransition.slideTransition,
        pageTransitionType: PageTransitionType.bottomToTop,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
