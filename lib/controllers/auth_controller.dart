import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _fireStore = FirebaseFirestore.instance;

  //Boolean to show loading.. when user is signing in
  RxBool isLoading = false.obs;
  RxBool isVerified = false.obs;
  /*=====FIREBASE AUTH INSTANCE======*/
  final _auth = FirebaseAuth.instance;

  /*=====GETTING CURRENT USER=====*/
  late final Rx<User?> _currentUser;
  Rx<User?> get currentUser => (_currentUser);
  RxString verificationId = ''.obs;
  RxString otp = ''.obs;

  /*=====METHOD TO REGISTER A NEW USER USING EMAIL AND PASSWORD=====*/
  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      isLoading.value = true;
      //creating account
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        isLoading.value = false;
        Get.to(() => HomePage());
        return value;
      });
      isLoading.value = false;
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
    } finally {
      isLoading.value = false;
    }
  }

  /*=====METHOD TO REGISTER A NEW USER USING EMAIL OR PHONE NUMBER=====*/
  Future<void> registerWithEmailOrPhoneNumber(
      String emailOrPhoneNumber, String password) async {
    if (emailOrPhoneNumber.contains('@')) {
      await registerWithEmailAndPassword(emailOrPhoneNumber, password);
    } else {
      await authenticatePhoneNumber(emailOrPhoneNumber);
    }
  }

  /*=====METHOD TO AUTHENTICATE PHONE NUMBER USING OTP=====*/
  Future<void> authenticatePhoneNumber(String phoneNumber) async {
    isLoading.value = true;
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential).then(
              (value) => Get.to(
                () => const HomePage(),
              ),
            );
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.back();
          Get.snackbar(
            'Invalid phone number',
            'Provided phone number is invalid, enter correct phone number',
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
            backgroundColor: Colors.red.withOpacity(0.2),
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
          isLoading.value = false;
        }
      },
      codeSent: (verificationId, resendToken) {
        isLoading.value = false;
        Get.to(() => OtpPage());
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
    );
  }

  /*=====METHOD TO VERIFY USER'S OTP=====*/
  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));
    isVerified.value = credentials.user != null ? true : false;
    return isVerified.value;
  }

  /*=====METHOD TO LOGIN USER USING EMAIL AND PASSWORD=====*/
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Show loading indicator
      isLoading.value = true;

      // Sign in the user with email and password
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.to(() => const HomePage());
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
      isLoading.value = false;
    }
  }

  /*=====METHOD TO LOGIN USER USING EMAIL OR PHONE NUMBER=====*/
  Future<void> signInWithEmailOrPhoneNumber(
      String emailOrPhoneNumber, String passwordOrOTP) async {
    if (emailOrPhoneNumber.contains('@')) {
      print('null');
      await signInWithEmailAndPassword(emailOrPhoneNumber, passwordOrOTP);
    } else {
      Get.to(() => const OtpPage());
      await authenticatePhoneNumber(emailOrPhoneNumber);
    }
  }

  /*=====METHOD TO LOGOUT USER=====*/
  Future<void> logoutUser() async {
    await _auth.signOut();
  }

  /*=====ON READY FUNCTION TO FETCH CURRENT USER=====*/
  @override
  void onReady() {
    _currentUser = Rx<User?>(_auth.currentUser);
    _currentUser.bindStream(_auth.userChanges());
    ever(_currentUser, _setInitialScreen);
  }

  /*=====CHECK IF THE USER IS LOGGED IN OR NOT=====*/
  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const LoginPage())
        : Get.offAll(() => const HomePage());
  }
}
