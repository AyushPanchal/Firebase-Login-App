import 'package:flutter/material.dart';
import 'package:login_app_firebase/constants/dimensions.dart';
import '../constants/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primaryColor,
      body: Column(
        children: [
          Image.asset('assets/images/login_image.png'),
        ],
      ),
    );
  }
}
