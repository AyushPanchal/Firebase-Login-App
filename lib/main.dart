import 'package:flutter/material.dart';
import 'package:login_app_firebase/screens/login_page.dart';
import 'constants/colors.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    ),
  );
}
