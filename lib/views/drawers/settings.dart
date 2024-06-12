import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secondapp/constants/constants.dart';
import 'package:secondapp/views/customs/custombutton.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            'Settings Page',
            style: TextStyle(fontSize: 24),
          ),
          AppButton(
            label: "go back",
            action: dashboard,
            textcolor: whitecolor,
          )
        ],
      ),
    );
  }

  void dashboard() {
    Get.toNamed("/dashboard");
  }
}
