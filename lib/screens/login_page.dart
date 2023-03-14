import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:login_app_firebase/constants/dimensions.dart';
import 'package:login_app_firebase/screens/signup_page.dart';
import 'package:login_app_firebase/widgets/custom_button.dart';
import '../constants/colors.dart';
import '../widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  static const id = "login_page_id";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.primaryColor,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        dragStartBehavior: DragStartBehavior.start,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.h20 * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: Dimensions.h20 * 7,
              ),
              Center(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset(
                    'assets/images/Mobile_login_png.png',
                  ),
                ),
              ),
              const SizedBox(
                height: Dimensions.h20 * 2,
              ),
              const Text(
                'Login',
                style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 35,
                    color: AppColours.activeColor),
              ),
              const SizedBox(
                height: Dimensions.h20 / 2,
              ),
              const Text(
                "Please Sign in to continue",
                style: TextStyle(color: AppColours.inactiveColor),
              ),
              const SizedBox(
                height: Dimensions.h20 * 3 / 2,
              ),
              CustomTextField(
                keyboardType: TextInputType.emailAddress,
                fillColor: AppColours.activeColor.withOpacity(0.2),
                prefixIcon: Icons.email_outlined,
                hintText: 'Email',
              ),
              const SizedBox(
                height: Dimensions.h20,
              ),
              CustomTextField(
                obscureText: true,
                fillColor: AppColours.activeColor.withOpacity(0.2),
                prefixIcon: Icons.lock_outline,
                hintText: 'Password',
              ),
              const SizedBox(
                height: Dimensions.h20 * 3 / 2,
              ),
              const Center(
                child: CustomButton(textData: "LOG IN"),
              ),
              const SizedBox(
                height: Dimensions.h20 * 2 / 3,
              ),
              const Center(
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(color: AppColours.componentsColor),
                ),
              ),
              const SizedBox(
                height: Dimensions.h20 * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: AppColours.inactiveColor),
                  ),
                  SizedBox(
                    width: Dimensions.h10 / 2,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, SignupPage.id);
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                          color: AppColours.componentsColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
