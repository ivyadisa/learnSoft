import 'package:get/get.dart';
import 'package:secondapp/views/dashboard.dart';
import 'package:secondapp/views/drawers/admissions.dart';
import 'package:secondapp/views/drawers/attendance.dart';
import 'package:secondapp/views/drawers/settings.dart';
import 'package:secondapp/views/homepage.dart';
import 'package:secondapp/views/forgotpassword.dart';
import 'package:secondapp/views/login.dart';
import 'package:secondapp/views/splashscreen.dart';

class Routes {
  static var routes = [
    GetPage(
      name: "/",
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: "/login",
      page: () => const LoginPage(),
    ),
    GetPage(
      name: "/homepage",
      page: () => const Homepage(),
    ),
    GetPage(
      name: "/forgotpassword",
      page: () => ForgotPassword(),
    ),
    GetPage(
      name: "/attendance",
      page: () => const AttendanceScreen(),
    ),
    GetPage(
      name: "/settings",
      page: () => const SettingsPage(),
    ),
    GetPage(
      name: "/admission",
      page: () => const AdmissionsPage(),
    ),
    GetPage(
      name: "/dashboard",
      page: () => const Dashboard(userName: '',),
    )
  ];
}
