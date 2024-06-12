// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:secondapp/constants/constants.dart';
import 'package:secondapp/services/sessions.dart';
import 'package:secondapp/views/customs/customtext.dart';
import 'package:secondapp/views/dashboard.dart';
import 'package:secondapp/views/homepage.dart';
import 'package:secondapp/views/login.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SessionManager sessionManager = SessionManager();

  @override
  void initState() {
    super.initState();
    checkSession();
  }

  Future<void> checkSession() async {
    bool isSessionExpired = await sessionManager.isSessionExpired();
    bool isFirstLogin = await sessionManager.isFirstLogin();

    if (isSessionExpired) {
      await sessionManager.clearSession();
      Get.off(() => LoginPage());
    } else if (isFirstLogin) {
      Get.off(() =>Homepage());
    } else {
      Get.off(() => Dashboard(userName: '',));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: backgroundcolor,
      splashIconSize: 250,
      duration: 3500,
      splashTransition: SplashTransition.fadeTransition,
      splash: Column(
        children: [
          Image.asset("assets/images/learnsoft.png"),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: "LearnSoft",
                textcolor: primarycolor,
                fontsize: 24,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                text: "Beliotech",
                textcolor: secondarycolor,
                fontsize: 24,
                fontWeight: FontWeight.bold,
              ),
            ],
          )
        ],
      ),
      nextScreen: Homepage(), 
    );
  }
}
