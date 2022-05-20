import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'home_page.dart';
import 'onboarding_screen.dart';
class SplashingScreen extends StatelessWidget {
  const SplashingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashTransition: SplashTransition.fadeTransition,
      nextScreen: const HomePage(),
      splash: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "images/news.svg",
            width: 70,
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "News App",
                style: GoogleFonts.titilliumWeb(
                    fontSize: 25.sp,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w400
                )
            ),
          )
        ],
      ),
    );
  }
}
