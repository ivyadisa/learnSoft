import 'package:flutter/material.dart';
import 'package:secondapp/constants/constants.dart';
import 'package:secondapp/views/customs/customcard.dart';
import 'package:secondapp/views/customs/customtextfield.dart';
import 'package:secondapp/views/dashboard.dart';
import 'package:secondapp/views/drawer.dart';
import 'package:secondapp/views/drawers/admissions.dart';
import 'package:secondapp/views/drawers/examination.dart';
import 'package:secondapp/views/drawers/settings.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const Dashboard(userName: '',),
    const AdmissionsPage(),
    const Examination(),
    const SettingsPage(),
  ];

  final List<DashboardCard> _cards = const [
    DashboardCard(
      imagePath: "assets/images/attendancereport.png",
      label: "Has a student attended today?Let's\nMark them in.",
      heading: "School Attendance",
      color: Color.fromRGBO(1, 51, 52, 0.9),
    ),
    DashboardCard(
      imagePath: "assets/images/gradeteachers.png",
      label: "How well is the teacher teaching?",
      heading: "Grade Teachers",
      color: Color.fromRGBO(5, 90, 79, 1),
    ),
    DashboardCard(
        imagePath: "assets/images/attendance.png",
        label: "Get the report of the attendance.",
        heading: "Today's Attendance Report",
        color: Color.fromRGBO(27, 112, 101, 1)),
    DashboardCard(
        imagePath: "assets/images/reports.png",
        label: "Get the overall report of the attendance.",
        heading: "Attendance Reports",
        color: Color.fromRGBO(54, 132, 110, 1)),
    DashboardCard(
      imagePath: "assets/images/reports.png",
      label: "View the student profile and update",
      heading: "Styudent Profile",
      color: Color.fromRGBO(27, 112, 101, 1),
    ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      drawer: DrawerScreen(onItemTapped: _onItemTapped),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: primarycolor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 45.0, top: 30, right: 45),
              child: CustomTextField(
                controller: _searchController,
                hint: "Search for module",
                prefixicon: const Icon(Icons.search),
                suffixicon: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.filter_alt_sharp)),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: _cards.map((card) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0), // Add vertical spacing between cards
                  child: card,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
