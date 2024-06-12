import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secondapp/controllers/routes.dart';
import 'package:secondapp/services/api.dart';
import 'package:secondapp/services/sessions.dart';

void main() {
  // Initialize and register ApiService
  Get.put(ApiService());

  // Initialize and register SessionManager
  final SessionManager sessionManager = SessionManager();
  Get.put(sessionManager);

  runApp(GetMaterialApp(
    initialRoute: "/",
    getPages: Routes.routes,
    debugShowCheckedModeBanner: false,
  ));
}
