// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import 'customs/custombutton.dart';
import 'customs/customtext.dart';
import 'customs/customtextbutton.dart';
import 'customs/customtextfield.dart';
import 'dashboard.dart';

class CustomDialogHeader extends StatelessWidget {
  final String title;

  const CustomDialogHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: secondarycolor,
      child: Text(
        title,
        style: TextStyle(
          color: primarycolor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class CustomDialogContent extends StatelessWidget {
  final String content;

  const CustomDialogContent({required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Text(content),
    );
  }
}

class CustomDialogIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const CustomDialogIcon({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color,
      size: 50,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = true;
  bool _showEmailError = false;
  bool _showPasswordError = false;
  bool _isLoading = false;

  Future<void> _signIn() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    setState(() {
      _showEmailError = email.isEmpty;
      _showPasswordError = password.isEmpty;
    });

    if (_showEmailError || _showPasswordError) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://demo.learnsoftschoolerp.co.ke/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final userName = responseData['user_name'];
        print('User Name: $userName');

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userName', userName);

        Get.offAll(() => Dashboard(userName: userName));
      } else {
        print('Failed to login');
        showPlatformDialog(
          context: context,
          builder: (_) => AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomDialogHeader(title: 'Login Failed'),
                CustomDialogContent(
                  content:
                      'Invalid credentials, please enter the correct email and or password',
                ),
                CustomDialogIcon(icon: Icons.error, color: Colors.red),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            ),
          ),
        );
      }
    } catch (error) {
      print('Error occurred: $error');

      showPlatformDialog(
        context: context,
        builder: (_) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomDialogHeader(title: 'Error'),
              CustomDialogContent(
                content: 'An error occurred. Please try again later.',
              ),
              CustomDialogIcon(icon: Icons.error, color: Colors.red),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: CustomText(
                        text: 'Welcome Back!',
                        textcolor: primarycolor,
                        fontWeight: FontWeight.bold,
                        fontsize: 26,
                      ),
                    ),
                    Image.asset(
                      'assets/images/learnsoft.png',
                      width: 50,
                      height: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Center(
                  child: Image.asset(
                    'assets/images/page2.png',
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: CustomText(
                    text: 'LearnifyApp | Login',
                    textcolor: primarycolor,
                    fontWeight: FontWeight.bold,
                    fontsize: 24,
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CustomTextField(
                          controller: _emailController,
                          prefixicon: const Icon(Icons.email),
                          hint: "Email",
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CustomTextField(
                          controller: _passwordController,
                          hideText: _showPassword,
                          hint: "Password",
                          prefixicon: const Icon(Icons.lock),
                          suffixicon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            icon: _showPassword
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                        ),
                      ),
                      if (_showPasswordError)
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Please enter your password.',
                            style: TextStyle(
                              color: secondarycolor,
                            ),
                          ),
                        ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 200.0),
                        child: CustomTextbutton(
                          label: "Forget Password?",
                          color: primarycolor,
                          action: () {
                            Get.offAndToNamed("/forgotpassword");
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: 300,
                        height: 41,
                        child: AppButton(
                          action: _signIn,
                          label: "Log into LearnifyApp",
                        ),
                      ),
                      if (_isLoading)
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
