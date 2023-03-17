import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:login_app_firebase/constants/dimensions.dart';
import 'package:login_app_firebase/controllers/auth_controller.dart';
import '../../widgets/error_message_signup_page.dart';
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
  final AuthController controller = Get.find();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.primaryColor,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        dragStartBehavior: DragStartBehavior.start,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.h20 * 2),
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
                CustomTextField(
                  controller: controller.loginEmailController,
                  keyboardType: TextInputType.emailAddress,
                  fillColor: AppColours.activeColor.withOpacity(0.2),
                  prefixIcon: Icons.email_outlined,
                  hintText: 'Email',
                ),
                ErrorMessage(
                  visibleCondition: !controller.loginEmailValidator.value &&
                      controller.isLoginFormValidated.value,
                  errorMessage: controller.emailError.value,
                ),
                const SizedBox(
                  height: Dimensions.h20,
                ),
                //Password
                CustomTextField(
                  controller: controller.loginPasswordController,
                  obscureText: LoginPage._obscureText,
                  fillColor: AppColours.activeColor.withOpacity(0.2),
                  prefixIcon: Icons.lock_outline,
                  hintText: 'Password',
                  onSuffixIconTap: () {
                    setState(() {
                      LoginPage._obscureText = !LoginPage._obscureText;
                    });
                  },
                  suffixIcon: LoginPage._obscureText
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                ErrorMessage(
                  visibleCondition: !controller.loginPasswordValidator.value &&
                      controller.isLoginFormValidated.value,
                  errorMessage: controller.passwordError.value,
                ),
                const SizedBox(
                  height: Dimensions.h20 * 3 / 2,
                ),
                Center(
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _formKey.currentState!.validate();
                          controller.validateLoginAll();
                        });
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
    );
  }
}
