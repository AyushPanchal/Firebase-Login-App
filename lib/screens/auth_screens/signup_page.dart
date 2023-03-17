import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_app_firebase/constants/colors.dart';
import 'package:login_app_firebase/constants/dimensions.dart';
import 'package:login_app_firebase/controllers/auth_controller.dart';
import 'package:login_app_firebase/widgets/custom_button.dart';
import 'package:login_app_firebase/widgets/custom_text_field.dart';

import '../../widgets/error_message_signup_page.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  static const id = "signup_page_id";
  static bool _obscureTextPassword = true;
  static bool _obscureTextConfirmPassword = true;
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final AuthController controller = Get.find();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColours.primaryColor,
        elevation: 0,
        leading: Icon(
          Icons.arrow_back_ios_new_outlined,
          size: 28,
        ),
      ),
      backgroundColor: AppColours.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.h20 * 2),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: Dimensions.h10,
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
                //Full name
                CustomTextField(
                  validator: (value) {
                    bool isValid = controller.validateFullName(value);
                    return isValid ? null : controller.fullNameError.value;
                  },
                  controller: controller.fullNameController,
                  keyboardType: TextInputType.text,
                  fillColor: AppColours.activeColor.withOpacity(0.2),
                  prefixIcon: Icons.person_outline_outlined,
                  hintText: 'Full Name',
                ),
                const SizedBox(
                  height: Dimensions.h20,
                ),
                //Phone number
                CustomTextField(
                  validator: (value) {
                    bool isValid = controller.validatePhoneNumber(value);
                    return isValid ? null : controller.phoneNumberError.value;
                  },
                  controller: controller.phoneNumberController,
                  keyboardType: TextInputType.phone,
                  fillColor: AppColours.activeColor.withOpacity(0.2),
                  prefixIcon: Icons.phone_android_sharp,
                  hintText: 'Phone Number',
                ),
                const SizedBox(
                  height: Dimensions.h20,
                ),
                //Email
                CustomTextField(
                  validator: (value) {
                    bool isValid = controller.validateEmail(value);
                    return isValid ? null : controller.emailError.value;
                  },
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  fillColor: AppColours.activeColor.withOpacity(0.2),
                  prefixIcon: Icons.email_outlined,
                  hintText: 'Email',
                ),

                const SizedBox(
                  height: Dimensions.h20,
                ),
                //Password
                CustomTextField(
                  validator: (value) {
                    bool isValid = controller.validatePassword(value);
                    return isValid ? null : controller.passwordError.value;
                  },
                  controller: controller.passwordController,
                  obscureText: SignupPage._obscureTextPassword,
                  keyboardType: TextInputType.text,
                  fillColor: AppColours.activeColor.withOpacity(0.2),
                  prefixIcon: Icons.lock_outline,
                  hintText: 'Password',
                  onSuffixIconTap: () {
                    setState(() {
                      SignupPage._obscureTextPassword =
                          !SignupPage._obscureTextPassword;
                    });
                  },
                  suffixIcon: SignupPage._obscureTextPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),

                const SizedBox(
                  height: Dimensions.h20,
                ),
                //Confirm Password
                CustomTextField(
                  validator: (value) {
                    bool isValid = controller.validateConfirmPassword(
                        value, controller.password);
                    return isValid
                        ? null
                        : controller.confirmPasswordError.value;
                  },
                  controller: controller.confirmPasswordController,
                  obscureText: SignupPage._obscureTextConfirmPassword,
                  keyboardType: TextInputType.text,
                  fillColor: AppColours.activeColor.withOpacity(0.2),
                  prefixIcon: Icons.lock_outline,
                  hintText: 'Confirm Password',
                  onSuffixIconTap: () {
                    setState(() {
                      SignupPage._obscureTextConfirmPassword =
                          !SignupPage._obscureTextConfirmPassword;
                    });
                  },
                  suffixIcon: SignupPage._obscureTextConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),

                const SizedBox(
                  height: Dimensions.h20 * 3 / 2,
                ),
                Center(
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _formKey.currentState!.validate();
                          controller.validateAll();
                        });
                      },
                      child: CustomButton(textData: "SIGN UP")),
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
      ),
    );
  }
}
