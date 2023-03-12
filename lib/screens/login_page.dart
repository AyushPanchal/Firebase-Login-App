import 'package:flutter/material.dart';
import 'package:login_app_firebase/constants/dimensions.dart';
import '../constants/colors.dart';
import '../widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.h20 * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: Dimensions.h20 * 7,
              ),
              Center(
                child: Image.asset(
                  'assets/images/login_image.png',
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
                hintText: 'Email Address',
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColours.componentsColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height: 65,
                    width: 230,
                    child: const Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: AppColours.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
