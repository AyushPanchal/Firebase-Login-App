import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_app_firebase/constants/colors.dart';
import 'package:login_app_firebase/constants/dimensions.dart';
import 'package:login_app_firebase/controllers/authentication_controllers/auth_controller.dart';
import 'package:login_app_firebase/controllers/authentication_controllers/validation_controller.dart';
import 'package:login_app_firebase/screens/auth_screens/auth_exports.dart';
import 'package:login_app_firebase/widgets/custom_button.dart';
import 'package:login_app_firebase/widgets/custom_text_field.dart';
import 'package:login_app_firebase/widgets/loading_widget.dart';

import '../../controllers/authentication_controllers/auth_data_controller.dart';
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
  final AuthController authController = Get.find();
  final AuthDataController authDataController = Get.find();
  final ValidationController validationController = Get.find();
  bool verifyWithEmail = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColours.primaryColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 28,
          ),
        ),
      ),
      backgroundColor: AppColours.primaryColor,
      body: SingleChildScrollView(
        reverse: true,
        child: Obx(() {
          return Stack(
            alignment: Alignment.center,
            children: [
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: authController.isLoading.value ? 0.2 : 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.h20 * 2,
                      vertical: Dimensions.h20 * 4),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verifyWithEmail
                            ? const SizedBox(height: Dimensions.h10)
                            : const SizedBox(
                                height: Dimensions.h20 * 3,
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
                            bool isValid =
                                validationController.validateFullName(value);
                            return isValid
                                ? null
                                : validationController.fullNameError.value;
                          },
                          controller: authDataController.fullNameController,
                          keyboardType: TextInputType.text,
                          fillColor: AppColours.activeColor.withOpacity(0.2),
                          prefixIcon: Icons.person_outline_outlined,
                          hintText: 'Full Name',
                        ),
                        const SizedBox(
                          height: Dimensions.h20,
                        ),
                        //Phone number
                        verifyWithEmail
                            ? CustomTextField(
                                validator: (value) {
                                  bool isValid =
                                      validationController.validateEmail(value);
                                  return isValid
                                      ? null
                                      : validationController.emailError.value;
                                },
                                controller: authDataController
                                    .emailOrPhoneNumberController,
                                keyboardType: TextInputType.emailAddress,
                                fillColor:
                                    AppColours.activeColor.withOpacity(0.2),
                                prefixIcon: Icons.email_outlined,
                                hintText: 'Email',
                              )
                            : CustomTextField(
                                validator: (value) {
                                  bool isValid = validationController
                                      .validatePhoneNumber(value);
                                  return isValid
                                      ? null
                                      : validationController
                                          .phoneNumberError.value;
                                },
                                controller: authDataController
                                    .emailOrPhoneNumberController,
                                keyboardType: TextInputType.phone,
                                fillColor:
                                    AppColours.activeColor.withOpacity(0.2),
                                prefixIcon: Icons.phone_android_sharp,
                                hintText: 'Phone Number',
                              ),

                        verifyWithEmail
                            ? const SizedBox(
                                height: Dimensions.h20,
                              )
                            : SizedBox.shrink(),
                        //Password
                        verifyWithEmail
                            ? CustomTextField(
                                validator: (value) {
                                  bool isValid = validationController
                                      .validatePassword(value);
                                  return isValid
                                      ? null
                                      : validationController
                                          .passwordError.value;
                                },
                                controller:
                                    authDataController.passwordController,
                                obscureText: SignupPage._obscureTextPassword,
                                keyboardType: TextInputType.text,
                                fillColor:
                                    AppColours.activeColor.withOpacity(0.2),
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
                              )
                            : SizedBox.shrink(),
                        verifyWithEmail
                            ? const SizedBox(
                                height: Dimensions.h20,
                              )
                            : const SizedBox.shrink(),
                        //Confirm Password
                        verifyWithEmail
                            ? CustomTextField(
                                validator: (value) {
                                  bool isValid = validationController
                                      .validateConfirmPassword(
                                          value, authDataController.password);
                                  return isValid
                                      ? null
                                      : validationController
                                          .confirmPasswordError.value;
                                },
                                controller: authDataController
                                    .confirmPasswordController,
                                obscureText:
                                    SignupPage._obscureTextConfirmPassword,
                                keyboardType: TextInputType.text,
                                fillColor:
                                    AppColours.activeColor.withOpacity(0.2),
                                prefixIcon: Icons.lock_outline,
                                hintText: 'Confirm Password',
                                onSuffixIconTap: () {
                                  setState(() {
                                    SignupPage._obscureTextConfirmPassword =
                                        !SignupPage._obscureTextConfirmPassword;
                                  });
                                },
                                suffixIcon:
                                    SignupPage._obscureTextConfirmPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                              )
                            : SizedBox.shrink(),
                        const SizedBox(
                          height: Dimensions.h10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              verifyWithEmail = !verifyWithEmail;
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Sign up using email',
                              style:
                                  TextStyle(color: AppColours.componentsColor),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: Dimensions.h20 * 3 / 2,
                        ),
                        Center(
                          child: GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  await authController
                                      .registerWithEmailOrPhoneNumber(
                                          authDataController.emailOrPhoneNumber
                                              .trim(),
                                          authDataController.password.trim());
                                }
                                validationController.validateAll();
                              },
                              child: CustomButton(textData: "SIGN UP")),
                        ),
                        const SizedBox(
                          height: Dimensions.h20 * 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(color: AppColours.inactiveColor),
                            ),
                            const SizedBox(
                              width: Dimensions.h10 / 2,
                            ),
                            InkWell(
                              onTap: () =>
                                  Navigator.pushNamed(context, LoginPage.id),
                              child: const Text(
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
              LoadingWidget(),
            ],
          );
        }),
      ),
    );
  }
}
