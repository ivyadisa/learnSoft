import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:secondapp/constants/constants.dart';
// import 'package:secondapp/controllers/admission_controller.dart';
import 'package:secondapp/views/customs/admissioncards.dart';
import 'package:secondapp/views/customs/customtext.dart';
import 'package:secondapp/views/customs/enrollment.dart';
import 'package:secondapp/views/customs/graderoster.dart';
import 'package:secondapp/views/customs/grades.dart';
import 'package:secondapp/views/customs/streams.dart';
import 'package:secondapp/views/customs/studentprofile.dart';
// import 'package:secondapp/views/customs/grades.dart';
import 'package:secondapp/views/dashboard.dart';
import 'package:secondapp/views/drawer.dart';
import 'package:secondapp/views/drawers/attendance.dart';
import 'package:secondapp/views/drawers/examination.dart';
import 'package:secondapp/views/drawers/settings.dart';

// AdmissionController admissionController = Get.put(AdmissionController());
late String userName;
class AdmissionsPage extends StatefulWidget {
  const AdmissionsPage({super.key});

  @override
  State<AdmissionsPage> createState() => _AdmissionsPageState();
}

class _AdmissionsPageState extends State<AdmissionsPage> {
  int _selectedIndex = 0;
  String? _selectedLabel;

  static final List<Widget> _widgetOptions = <Widget>[
    const Dashboard(userName: '',),
    const AdmissionsPage(),
    const Examination(),
    const AttendanceScreen(),
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _widgetOptions[_selectedIndex]),
    );
  }

  void _onCardTapped(String label) {
    setState(() {
      _selectedLabel = label;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundcolor,
        drawer: DrawerScreen(
          onItemTapped: _onItemTapped,
        ),
        appBar: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: backgroundcolor,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: CustomText(
                text: "Donald Edwin",
                textcolor: primarycolor,
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomText(
                  text: "Admission",
                  textcolor: primarycolor,
                  fontsize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    AdmissionCard(
                      label: "Enrollment",
                      isSelected: _selectedLabel == "Enrollment",
                      onTap: () => _onCardTapped("Enrollment"),
                    ),
                    AdmissionCard(
                      label: "Grade Roster",
                      isSelected: _selectedLabel == "Grade Roster",
                      onTap: () => _onCardTapped("Grade Roster"),
                    ),
                    AdmissionCard(
                      label: "Student Profile",
                      isSelected: _selectedLabel == "Student Profile",
                      onTap: () => _onCardTapped("Student Profile"),
                    ),
                    AdmissionCard(
                      label: "Streams",
                      isSelected: _selectedLabel == "Streams",
                      onTap: () => _onCardTapped("Streams"),
                    ),
                    AdmissionCard(
                      label: "Grades",
                      isSelected: _selectedLabel == "Grades",
                      onTap: () => _onCardTapped("Grades"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _selectedLabel == "Enrollment"
                    ? const Enrollment()
                    : _selectedLabel == "Grade Roster"
                        ? const Grades()
                        : _selectedLabel == "Grades"
                            ? GradesPage()
                            : _selectedLabel == "Streams"
                                ? const Streams()
                                : _selectedLabel == "Student Profile"
                                    ? const Studentprofile()
                                    : const Center(
                                        child: Text("Select an option")),
              ),
            ],
          ),
        ));
  }
}
