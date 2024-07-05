import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:mist_app/constants/fonts.dart';
import 'get_started.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
          duration: 3000,
          backgroundColor: Colors.black,
          splash: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Image(
                  image: AssetImage("assets/images/logo 1.png"),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'Smart Road Service',
                    speed: const Duration(milliseconds: 180),
                    textStyle: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: fontFamily2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          splashIconSize: 250,
          nextScreen: const GetStartedScreen()),
    );
  }
}
