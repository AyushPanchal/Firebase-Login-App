import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:login_app_firebase/constants/dimensions.dart';
import 'package:login_app_firebase/controllers/auth_controller.dart';
import 'package:login_app_firebase/controllers/auth_data_controller.dart';
import 'package:login_app_firebase/controllers/validation_controller.dart';
import 'package:login_app_firebase/screens/auth_screens/auth_exports.dart';
import 'package:login_app_firebase/widgets/loading_widget.dart';
import '../../controllers/validation_controller.dart';
import 'signup_page.dart';
import 'package:login_app_firebase/widgets/custom_button.dart';
import '../../constants/colors.dart';
import '../../widgets/custom_text_field.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  static const id = "login_page_id";
  static bool _obscureText = true;
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController authController = Get.find();
  final AuthDataController authDataController = Get.find();
  final ValidationController validationController = Get.find();
  bool _verifyWithEmail = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    authDataController.phoneNumberController.text = '+91';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.primaryColor,
      body: SingleChildScrollView(
        reverse: true,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        dragStartBehavior: DragStartBehavior.start,
        child: Obx(
          () => Stack(
            alignment: Alignment.center,
            children: [
              LoadingWidget(),
              AnimatedOpacity(
                opacity: authController.isLoading.value ? 0.2 : 1,
                duration: const Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.h20 * 2,
                  ),
                  child: Form(
                    key: _formKey,
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
                        //Email
                        _verifyWithEmail
                            ? CustomTextField(
                                validator: (value) {
                                  bool isValid = validationController
                                      .validateLoginEmail(value);
                                  return isValid
                                      ? null
                                      : validationController.emailError.value;
                                },
                                controller: authDataController
                                    .loginEmailOrPhoneNumberController,
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
                                    .loginEmailOrPhoneNumberController,
                                keyboardType: TextInputType.phone,
                                fillColor:
                                    AppColours.activeColor.withOpacity(0.2),
                                prefixIcon: Icons.phone_android_sharp,
                                hintText: '+91 | Phone Number',
                              ),
                        const SizedBox(
                          height: Dimensions.h20,
                        ),
                        //Password
                        _verifyWithEmail
                            ? CustomTextField(
                                validator: (value) {
                                  bool isValid = validationController
                                      .validateLoginPassword(value);
                                  return isValid
                                      ? null
                                      : validationController
                                          .passwordError.value;
                                },
                                controller:
                                    authDataController.loginPasswordController,
                                obscureText: LoginPage._obscureText,
                                fillColor:
                                    AppColours.activeColor.withOpacity(0.2),
                                prefixIcon: Icons.lock_outline,
                                hintText: 'Password',
                                onSuffixIconTap: () {
                                  setState(() {
                                    LoginPage._obscureText =
                                        !LoginPage._obscureText;
                                  });
                                },
                                suffixIcon: LoginPage._obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              )
                            : SizedBox.shrink(),
                        _verifyWithEmail
                            ? const SizedBox(
                                height: Dimensions.h10,
                              )
                            : SizedBox.shrink(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _verifyWithEmail = !_verifyWithEmail;
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
                          height: Dimensions.h20,
                        ),
                        Center(
                          child: GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  await authController
                                      .signInWithEmailOrPhoneNumber(
                                          authDataController
                                              .loginEmailOrPhoneNumberController
                                              .text
                                              .trim(),
                                          authDataController.loginPassword
                                              .trim());
                                }
                                validationController.validateLoginAll();
                              },
                              child: CustomButton(textData: "LOG IN")),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
