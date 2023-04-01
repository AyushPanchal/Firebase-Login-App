import 'package:flutter/material.dart';
import 'package:login_app_firebase/constants/exports_constants.dart';
import 'package:get/get.dart';
import 'package:login_app_firebase/controllers/authentication_controllers/auth_controller.dart';
import 'package:login_app_firebase/screens/auth_screens/auth_exports.dart';

class WelcomePage extends StatefulWidget {
  static const String id = 'welcome_page_id';
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final AuthController _authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.primaryColor,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(Dimensions.h20 * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Image
                SizedBox(
                  height: 300,
                  width: 200,
                  child: Image.asset(
                    'assets/images/Team_illustration.png',
                  ),
                ),
                //Welcome to eventoV text
                const Text(
                  kWelcomePageTitle,
                  style: TextStyle(
                    fontSize: 33,
                    color: AppColours.activeColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: Dimensions.h20 * 4,
                ),
                //Information text
                const Text(
                  'Ignite your passion for social change by connecting with like minded volunteers and event organizers!',
                  style: TextStyle(
                    fontSize: 19,
                    color: AppColours.componentsColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            //Buttons
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          36,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.h15,
                      ),
                      side: const BorderSide(
                        color: AppColours.componentsColor,
                      ),
                      primary: AppColours.componentsColor,
                    ),
                    onPressed: () {
                      Get.to(() => const LoginPage());
                    },
                    child: const Text(
                      kLogin,
                    ),
                  ),
                ),
                const SizedBox(
                  width: Dimensions.h10,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.circular(
                          36,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.h15,
                      ),
                      primary: AppColours.componentsColor,
                      onPrimary: AppColours.primaryColor,
                    ),
                    onPressed: () {
                      Get.to(
                        () => const SignupPage(),
                        transition: Transition.leftToRightWithFade,
                      );
                    },
                    child: const Text(kSignUp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
