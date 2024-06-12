import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:secondapp/constants/constants.dart';
import 'package:secondapp/views/customs/customtext.dart';
import 'package:url_launcher/url_launcher.dart';

class Profilecard extends StatelessWidget {
  final String label;
  final Icon? icon;
  final String? phoneNumber;

  const Profilecard(
      {Key? key, required this.label, this.icon, this.phoneNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        height: 50,
        width: currentWidth * 0.9,
        decoration: BoxDecoration(
          border: Border.all(color: primarycolor),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: primarycolor.withOpacity(0.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomText(
                text: label,
                fontWeight: FontWeight.w400,
                fontsize: 14,
              ),
            ),
            if (icon != null)
              GestureDetector(
                onTap: () {
                  if (phoneNumber != null) {
                    FlutterPhoneDirectCaller.callNumber(phoneNumber!);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: icon!,
                ),
              ),

          ],
        ),
      ),
    );
  }

 
}
