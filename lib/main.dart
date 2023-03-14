import 'package:flutter/material.dart';
import 'package:login_app_firebase/screens/login_page.dart';
import 'package:login_app_firebase/screens/otp_page.dart';
import 'package:login_app_firebase/screens/signup_page.dart';
// import 'package:login_app_firebase/screens/signup_page.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: OtpPage.id,
      routes: {
        LoginPage.id: (context) => const LoginPage(),
        SignupPage.id: (context) => const SignupPage(),
        OtpPage.id: (context) => const OtpPage(),
      },
      theme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    ),
  );
}
