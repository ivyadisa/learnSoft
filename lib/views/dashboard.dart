// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:secondapp/views/customs/dashgrid.dart';
import 'package:secondapp/views/customs/piechart.dart';
import 'package:secondapp/views/drawer.dart';
import 'package:secondapp/views/drawers/admissions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';
import '../constants/constants.dart';
import '../models/dashboardmodel.dart';
import '../services/api.dart';
import 'customs/customcontainer.dart';
import 'customs/customtext.dart';
import 'customs/feepayment.dart';
import 'customs/incomegraph.dart';
import 'drawers/attendance.dart';
import 'drawers/examination.dart';
import 'drawers/settings.dart';
import 'package:intl/intl.dart';
class Dashboard extends StatefulWidget {
  final String userName;

  const Dashboard({Key? key, required this.userName}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class FingerprintStorage {
  static const _kFingerprintKey = 'fingerprint';

  static Future<bool> hasStoredFingerprint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kFingerprintKey) ?? false;
  }

  static Future<void> storeFingerprint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kFingerprintKey, true);
  }

  static Future<void> clearStoredFingerprint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kFingerprintKey);
  }
}

class _DashboardState extends State<Dashboard> {
  late Future<DashboardData> futureData;
  bool fingerprintEnabled = false;
  bool isDarkTheme = false;

  @override
  void initState() {
    super.initState();
    futureData =
        ApiService().fetchData().then((data) => DashboardData.fromJson(data));
  }

  void toggleFingerprint(bool value) {
    setState(() {
      fingerprintEnabled = value;
      // Save the preference for fingerprint authentication
      // You can use shared_preferences or any other storage mechanism
    });
  }

  void toggleTheme(bool value) {
    setState(() {
      isDarkTheme = value;
      // Update app theme based on value
      // Example: AppTheme.toggleTheme(value);
    });
  }

  Future<void> _captureFingerprint() async {
    try {
      bool authenticated = await LocalAuthentication().authenticate(
        localizedReason: 'Authenticate to capture fingerprint',
      );
      if (authenticated) {
        await FingerprintStorage.storeFingerprint();
        print('Fingerprint stored successfully');
      }
    } catch (e) {
      print('Error capturing fingerprint: $e');
    }
  }

  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const Dashboard(userName: ''), // Placeholder, will not be used
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

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData =
        isDarkTheme ? ThemeData.dark() : ThemeData.light();

    return Scaffold(
      drawer: DrawerScreen(
        onItemTapped: _onItemTapped,
      ),
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: backgroundcolor,
        actions: [
          IconButton(
            onPressed: () {
              // Add your notification handling logic here
            },
            icon: const Icon(
              Icons.notifications_none,
              color: primarycolor,
            ),
          ),
          IconButton(
            onPressed: () {
              toggleFingerprint(!fingerprintEnabled);
            },
            icon: Icon(
              fingerprintEnabled
                  ? Icons.fingerprint
                  : Icons.fingerprint_outlined,
              color: fingerprintEnabled ? Colors.green : Colors.grey,
            ),
          ),
          Switch(
            value: isDarkTheme,
            onChanged: (value) {
              toggleTheme(value);
            },
          ),
          IconButton(
            onPressed: () {
              _captureFingerprint();
            },
            icon: Icon(
              Icons.add_box,
              color: secondarycolor,
            ),
          ),
        ],
      ),
      backgroundColor: backgroundcolor,
      body: FutureBuilder<DashboardData>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            DashboardData data = snapshot.data!;

            // Determine the time of the day
            DateTime now = DateTime.now();
            String greeting = '';
            if (now.hour < 12) {
              greeting = 'Good Morning';
            } else if (now.hour < 18) {
              greeting = 'Good Afternoon';
            } else {
              greeting = 'Good Evening';
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: '$greeting,\n ${widget.userName}',
                            textcolor: secondarycolor,
                            fontWeight: FontWeight.bold,
                            fontsize: 20,
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: primarycolor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: CustomText(
                          text: 'Today is ' +
                              DateFormat('MMM dd yyyy').format(DateTime.now()),
                          textcolor: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontsize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: secondarycolor,
                  margin: EdgeInsets.symmetric(vertical: 8),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CustomContainer(
                          child: FeesPaymentChart(),
                        ),
                        IncomeGraphContainer(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(40.0),
                              child: IncomeGraph(
                                totalIncomes: data.totalIncomes,
                                sumExpenses: data.sumExpenses,
                              ),
                            ),
                          ),
                        ),
                        PieChartContainer(
                          child: Padding(
                            padding: EdgeInsets.all(18.0),
                            child: PieChartSample(
                              totalParents: data.totalParents,
                              totalStudents: data.totalStudents,
                              totalTeachers: data.totalTeachers,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CustomText(
                      text: "Overview",
                      fontWeight: FontWeight.bold,
                      fontsize: 24,
                      textcolor: secondarycolor,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: DashGrid(data: data),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
