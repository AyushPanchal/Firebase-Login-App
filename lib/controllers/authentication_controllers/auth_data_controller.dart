import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthDataController extends GetxController {
  //controllers to extract text from TextFormField in signup form
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final emailOrPhoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //fields in signup form
  String get fullName => fullNameController.text;
  String get phoneNumber => phoneNumberController.text;
  String get email => emailController.text;
  String get emailOrPhoneNumber => emailOrPhoneNumberController.text;
  String get password => passwordController.text;
  String get confirmPassword => confirmPasswordController.text;

  //Login page textFormField controllers
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final loginEmailOrPhoneNumberController = TextEditingController();

  //fields for login page
  String get loginEmail => loginEmailController.text;
  String get loginEmailOrPhoneNumber => loginEmailOrPhoneNumberController.text;
  String get loginPassword => loginPasswordController.text;

  void clearControllers() {
    fullNameController.clear();
    loginEmailController.clear();
    loginEmailOrPhoneNumberController.clear();
    loginPasswordController.clear();
    phoneNumberController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    emailOrPhoneNumberController.clear();
  }

  @override
  void dispose() {
    loginEmailController.dispose();
    loginEmailOrPhoneNumberController.dispose();
    loginPasswordController.dispose();
    emailOrPhoneNumberController.dispose();
    fullNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
