// mport 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:secondapp/constants/constants.dart';
import 'package:secondapp/views/customs/customtext.dart';

class AdmissionCard extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const AdmissionCard({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.30,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: isSelected ? secondarycolor: primarycolor,
          child: Center(
            child: CustomText(
              text: label,
              textcolor: whitecolor,
            ),
          ),
        ),
      ),
    );
  }
}