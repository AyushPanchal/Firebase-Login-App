import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:login_app_firebase/controllers/validation_controller.dart';
import 'package:login_app_firebase/screens/auth_screens/auth_exports.dart';

import '../screens/home_page.dart';
// import 'package:login_app_firebase/controllers/auth_data_controller.dart';

class AuthController extends GetxController {
  // final _authData = Get.find<AuthDataController>();
  final _validationController = Get.find<ValidationController>();

  //Boolean to show loading.. when user is signing in
  RxBool isLoading = false.obs;

  /*=====FIREBASE AUTH INSTANCE======*/
  final _auth = FirebaseAuth.instance;

  /*=====GETTING CURRENT USER=====*/
  late final Rx<User?> _currentUser;

  /*=====METHOD TO REGISTER A NEW USER USING EMAIL AND PASSWORD=====*/
  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      isLoading.value = !isLoading.value;
      //creating account
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.sendEmailVerification();
      isLoading.value = !isLoading.value;
      Get.offAll(() => const OtpPage());
    } on FirebaseAuthException catch (e) {
      //Handling various exceptions
      if (e.code == 'weak-password') {
        // Handle weak password
        Get.snackbar(
          'Weak Password',
          e.message!,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
          backgroundColor: Colors.red.withOpacity(0.2),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      } else if (e.code == 'email-already-in-use') {
        // Handle email already in use error
        Get.snackbar(
          'Email already in use',
          e.message!,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
          backgroundColor: Colors.red.withOpacity(0.2),
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      } else {
        // Handle other errors
        Get.snackbar(
          e.code,
          e.message!,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
          backgroundColor: Colors.red.withOpacity(0.2),
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      }
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Show loading indicator
      isLoading(true);

      // Sign in the user with email and password
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Handle user not found error
        Get.snackbar(
          'User not found',
          e.message!,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
          backgroundColor: Colors.red.withOpacity(0.2),
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      } else if (e.code == 'wrong-password') {
        // Handle wrong password error
        Get.snackbar(
          'Incorrect password!',
          e.message!,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
          backgroundColor: Colors.red.withOpacity(0.2),
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      } else {
        // Handle other errors
        Get.snackbar(
          e.code,
          e.message!,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
          backgroundColor: Colors.red.withOpacity(0.2),
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      }
    } finally {
      // Hide loading indicator
      isLoading(false);
    }
  }

  @override
  void onReady() {
    _currentUser = Rx<User?>(_auth.currentUser);
    _currentUser.bindStream(_auth.userChanges());
    ever(_currentUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const LoginPage())
        : Get.offAll(() => const HomePage());
  }
}
