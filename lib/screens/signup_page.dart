import 'package:flutter/material.dart';
import 'package:login_app_firebase/constants/colors.dart';
import 'package:login_app_firebase/constants/dimensions.dart';
import 'package:login_app_firebase/widgets/custom_button.dart';
import 'package:login_app_firebase/widgets/custom_text_field.dart';

import 'login_page.dart';

class SignupPage extends StatefulWidget {
  static const id = "signup_page_id";
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.h20 * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: Dimensions.h20 * 3),
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 28,
                ),
              ),
              const SizedBox(
                height: Dimensions.h20 * 2,
              ),
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: AppColours.activeColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Please enter your details",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColours.inactiveColor,
                ),
              ),
              const SizedBox(
                height: Dimensions.h20 * 2,
              ),
              CustomTextField(
                keyboardType: TextInputType.text,
                fillColor: AppColours.activeColor.withOpacity(0.2),
                prefixIcon: Icons.person_outline_outlined,
                hintText: 'Full Name',
              ),
              const SizedBox(
                height: Dimensions.h20,
              ),
              CustomTextField(
                keyboardType: TextInputType.phone,
                fillColor: AppColours.activeColor.withOpacity(0.2),
                prefixIcon: Icons.phone_android_sharp,
                hintText: 'Phone Number',
              ),
              const SizedBox(
                height: Dimensions.h20,
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
                keyboardType: TextInputType.text,
                fillColor: AppColours.activeColor.withOpacity(0.2),
                prefixIcon: Icons.lock_outline,
                hintText: 'Password',
              ),
              const SizedBox(
                height: Dimensions.h20,
              ),
              CustomTextField(
                obscureText: true,
                keyboardType: TextInputType.text,
                fillColor: AppColours.activeColor.withOpacity(0.2),
                prefixIcon: Icons.lock_outline,
                hintText: 'Confirm Password',
              ),
              const SizedBox(
                height: Dimensions.h20 * 3 / 2,
              ),
              const Center(
                child: CustomButton(textData: "SIGN UP"),
              ),
              const SizedBox(
                height: Dimensions.h20 * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: AppColours.inactiveColor),
                  ),
                  SizedBox(
                    width: Dimensions.h10 / 2,
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, LoginPage.id),
                    child: Text(
                      "Sign in",
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
