import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/google_ads_controller.dart';
import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 6),
          () => Get.off(
            () => const HomePage(),
        curve: Curves.easeInOut,
        transition: Transition.fadeIn,
      ),
    );
    AdHelper.adHelper.loadInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.indigo.shade400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              duration: const Duration(seconds: 5),
              curve: Curves.easeInOut,
              tween: Tween<double>(begin: -440, end: 0),
              builder: (context, val, widget) => Transform.translate(
                offset: Offset(0, val),
                child: Image.asset(
                  'assets/images/icon.png',
                  filterQuality: FilterQuality.high,
                  scale: 2,
                ),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  "Random color generator",
                  curve: Curves.easeInOut,
                  cursor: '',
                  speed: const Duration(milliseconds: 200),
                  textStyle: GoogleFonts.arya(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
