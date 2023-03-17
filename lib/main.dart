import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/auth_screens/auth_exports.dart';
import './helper/dependency_injection.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
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
