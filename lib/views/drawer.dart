import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';
// import 'package:get/get.dart';
import 'package:secondapp/constants/constants.dart';
import 'package:secondapp/views/customs/customdrawer.dart';
// import 'package:secondapp/views/customs/customdrawer.dart';

class DrawerScreen extends StatelessWidget {
  final Function(int) onItemTapped;
  const DrawerScreen({super.key, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primarycolor,
      child: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "LearnSoft",
                    style: TextStyle(
                        color: whitecolor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.cancel),
                    color: whitecolor,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            DrawerItem(
              icon: Icons.dashboard_outlined,
              text: "Dashboard",
              onTap: () => onItemTapped(0),
            ),
            DrawerItem(
              icon: Icons.people_alt_outlined,
              text: "Admissions",
              onTap: () => onItemTapped(1),
            ),
            DrawerItem(
              icon: Icons.money_sharp,
              text: "Finances",
              onTap: () => onItemTapped(2),
            ),
            DrawerItem(
              icon: Icons.money_sharp,
              text: "examination",
              onTap: () => onItemTapped(2),
            ),
            DrawerItem(
              icon: Icons.people,
              text: "teachers&parents",
              onTap: () => onItemTapped(2),
            ),
            DrawerItem(
              icon: Icons.message,
              text: "Communication",
              onTap: () => onItemTapped(2),
            ),
            DrawerItem(
              icon: Icons.event_available,
              text: "Attendance",
              onTap: () => onItemTapped(3),
            ),
            // DrawerItem(
            //   icon: Icons.people_alt_outlined,
            //   text: "Admissions",
            //   onTap: () => onItemTapped(1),
            // ),
            // DrawerItem(
            //   icon: Icons.settings_applications,
            //   text: "Controls",
            //   onTap: () {},
            // ),
            DrawerItem(
              icon: Icons.settings,
              text: "Settings",
              onTap: () => onItemTapped(4),
            ),
            const SizedBox(
              height: 50,
            ),
            DrawerItem(
              icon: Icons.logout_outlined,
              text: "Log Out",
              onTap: login,
            ),
          ],
        ),
      ),
    );
  }

  void login() {
    Get.toNamed("/login");
  }
}
