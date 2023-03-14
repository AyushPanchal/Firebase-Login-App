import 'package:flutter/material.dart';
import 'package:login_app_firebase/constants/colors.dart';
import 'package:login_app_firebase/constants/dimensions.dart';
import 'package:login_app_firebase/widgets/custom_button.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  static const id = "otp_page_id";
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: Dimensions.h20 * 4,
              ),
              Icon(
                Icons.arrow_back_ios_new,
                size: 28,
              ),
              SizedBox(
                height: Dimensions.h20,
              ),
              Image.asset('assets/images/otp_page_image-removebg.png'),
              SizedBox(
                height: Dimensions.h20,
              ),
              const Text(
                "Verify Your phone number",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColours.activeColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Please enter your OTP code here",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColours.inactiveColor,
                ),
              ),
              SizedBox(
                height: Dimensions.h20 * 1.5,
              ),
              Pinput(
                length: 6,
              ),
              SizedBox(
                height: Dimensions.h20 * 1.5,
              ),
              Center(
                child: CustomButton(textData: "SUBMIT"),
              ),
              SizedBox(
                height: Dimensions.h20,
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Did you receive any code?",
                      style: TextStyle(color: AppColours.inactiveColor),
                    ),
                    SizedBox(
                      height: Dimensions.h20 / 4,
                    ),
                    GestureDetector(
                      child: Text(
                        "RESEND CODE",
                        style: TextStyle(
                            color: AppColours.componentsColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
