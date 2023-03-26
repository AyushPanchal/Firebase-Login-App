import 'package:flutter/material.dart';
import 'package:login_app_firebase/constants/dimensions.dart';
import 'package:login_app_firebase/constants/exports_constants.dart';
import 'otp_page.dart';
import 'signup_page.dart';
import 'package:login_app_firebase/widgets/custom_button.dart';
import 'package:login_app_firebase/widgets/custom_text_field.dart';
import '../../constants/colors.dart';

class ForgetPasswordPage extends StatefulWidget {
  static const String id = "forget_password_page_id";
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.primaryColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Forget Password",
          style: TextStyle(color: AppColours.activeColor),
        ),
        backgroundColor: AppColours.primaryColor,
        leading: const Icon(Icons.arrow_back_ios_new),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.h20),
          child: Column(
            children: [
              SizedBox(
                height: Dimensions.h20 * 3 / 2,
              ),
              Center(
                child: SizedBox(
                  height: 200,
                  child: Image.asset('assets/images/forget_password_ill.png'),
                ),
              ),
              SizedBox(
                height: Dimensions.h20,
              ),
              Text(
                'Enter Email Address',
                style: TextStyle(
                  color: AppColours.componentsColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: Dimensions.h20 * 3 / 2,
              ),
              CustomTextField(
                fillColor: AppColours.activeColor.withOpacity(0.2),
                prefixIcon: Icons.email_outlined,
                hintText: "Email",
              ),
              SizedBox(
                height: Dimensions.h20 * 3 / 2,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, OtpPage.id);
                  },
                  child: SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppColours.componentsColor,
                        padding: EdgeInsets.symmetric(vertical: Dimensions.h15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'SEND OTP',
                        style: TextStyle(
                            fontSize: 18, color: AppColours.primaryColor),
                      ),
                    ),
                  )),
              SizedBox(
                height: Dimensions.h20 * 3 / 2,
              ),
              Text(
                "Don't have an account?",
                style: TextStyle(
                    color: AppColours.activeColor.withOpacity(0.6),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: Dimensions.h20 * 2 / 3,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, SignupPage.id);
                },
                child: SizedBox(
                  width: double.maxFinite,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColours.componentsColor),
                      padding: EdgeInsets.symmetric(vertical: Dimensions.h15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      kSignUp,
                      style: TextStyle(
                          fontSize: 18, color: AppColours.componentsColor),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
