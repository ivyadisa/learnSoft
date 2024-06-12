import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secondapp/constants/constants.dart';
import 'package:secondapp/views/customs/custombutton.dart';
import 'package:secondapp/views/customs/customtext.dart';
import 'package:secondapp/views/customs/customtextfield.dart';

final TextEditingController emailController = TextEditingController();

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 0.41, right: 0.41, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/learnsoft.png',
                        height: 45,
                        width: 45,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 60),
                  child: Image.asset(
                    'assets/images/password.png',
                    height: 307,
                    fit: BoxFit.contain,
                  ),
                ),
                CustomText(
                  text: "Forgot Password?",
                  fontsize: 24,
                  fontWeight: FontWeight.bold,
                  textcolor: primarycolor,
                ),
                SizedBox(height: 10.0),
                CustomText(
                  text: "you can easily retrieve your new password",
                  fontsize: 13,
                  textcolor: primarycolor,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 38.0),
                CustomTextField(
                  controller: emailController,
                  hint: "Email",
                  prefixicon: Icon(Icons.email_outlined),
                ),
                SizedBox(height: 25.0),
                AppButton(label: "Continue", action: home),
                SizedBox(height: 20.0), // Add some space before the footer text
                CustomText(
                  text: "Learnsoft Beliotech Solutions Limited",
                  fontsize: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void home() {
    Get.offAllNamed("/");
  }
}
