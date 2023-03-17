import 'package:flutter/material.dart';
import 'screens/auth_screens/auth_exports.dart';
import './helper/dependency_injection.dart';

void main() {
  init();
  runApp(
    MaterialApp(
      initialRoute: ForgetPasswordPage.id,
      routes: {
        '/': (context) => const LoginPage(),
        LoginPage.id: (context) => const LoginPage(),
        SignupPage.id: (context) => const SignupPage(),
        OtpPage.id: (context) => const OtpPage(),
      },
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
    ),
  );
}
