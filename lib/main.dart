import 'package:flutter/material.dart';
import 'package:login_app_firebase/screens/login_page.dart';
// import 'package:login_app_firebase/screens/signup_page.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    ),
  );
}
