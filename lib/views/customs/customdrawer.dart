//custom for the listtile used in the drawer 
import 'package:flutter/material.dart';
import 'package:secondapp/constants/constants.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final GestureTapCallback onTap;
  final Color textColor;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: secondarycolor),
      title: Text(
        text,
        style: const TextStyle(
          color: whitecolor,
        ),
      ),
      onTap: onTap,
    );
  }
}
