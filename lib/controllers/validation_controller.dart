import 'package:get/get.dart';
import 'package:login_app_firebase/controllers/auth_controller.dart';
import 'package:login_app_firebase/controllers/auth_data_controller.dart';

class ValidationController extends GetxController {
  final _authData = Get.find<AuthDataController>();
  //To check if form in signup is validated or not!
  final RxBool isFormValidated = false.obs;
  final RxBool isLoginFormValidated = false.obs;

  //for the error messages to show in sign up page
  RxString fullNameError = RxString('');
  RxString phoneNumberError = RxString('');
  RxString emailError = RxString('');
  RxString passwordError = RxString('');
  RxString confirmPasswordError = RxString('');

  //to valid fields to show the error text else nothing is showed
  RxBool fullNameValidator = false.obs;
  RxBool phoneNumberValidator = false.obs;
  RxBool emailValidator = false.obs;
  RxBool passwordValidator = false.obs;
  RxBool confirmPasswordValidator = false.obs;

  // validate full name
  bool validateFullName(String fullName) {
    if (fullName.isEmpty) {
      fullNameValidator.value = false;
      fullNameError.value = 'Full name is required';
      return false;
    } else if (fullName.length < 2) {
      fullNameError.value = 'Full name must be at least 2 characters long';
      return false;
    } else {
      fullNameError.value = '';
      fullNameValidator.value = true;
      return true;
    }
  }

  //validate phone number
  bool validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      phoneNumberError.value = 'Phone number is required';
      phoneNumberValidator.value = false;
      return false;
    } else if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(phoneNumber)) {
      phoneNumberError.value = 'Invalid phone number';
      return false;
    } else {
      phoneNumberError.value = '';
      phoneNumberValidator.value = true;
      return true;
    }
  }

  //validate email
  bool validateEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    if (email.isEmpty) {
      emailError.value = 'Email is required';
      emailValidator.value = false;
      return false;
    } else if (!emailRegex.hasMatch(email)) {
      emailError.value = 'Invalid email format';
      return false;
    } else {
      emailError.value = '';
      emailValidator.value = true;
      return true;
    }
  }

  //validate password
  bool validatePassword(String password) {
    // Password must be at least 8 characters long
    if (password.length < 8) {
      passwordError.value = 'Password must be at least 8 characters long';
      passwordValidator.value = false;
      return false;
    }

    // Password must contain at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      passwordError.value =
          'Password must contain at least one uppercase letter';
      return false;
    }

    // Password must contain at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      passwordError.value =
          'Password must contain at least one lowercase letter';

      return false;
    }

    // Password must contain at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      passwordError.value = 'Password must contain at least one digit';
      return false;
    }

    passwordError.value = '';
    passwordValidator.value = true;
    return true;
  }

  //validate confirm password
  bool validateConfirmPassword(String confirmPassword, String password) {
    if (confirmPassword.isEmpty) {
      confirmPasswordError.value = 'Confirm password is required';
      confirmPasswordValidator.value = false;
      return false;
    } else if (confirmPassword != password) {
      confirmPasswordError.value = 'Passwords do not match';
      return false;
    } else {
      confirmPasswordError.value = '';
      confirmPasswordValidator.value = true;
      return true;
    }
  }

  //after validating all the fields in form ,we set form validated to true!!
  void validateAll() {
    validateFullName(_authData.fullName);
    validatePhoneNumber(_authData.phoneNumber);
    validateEmail(_authData.email);
    validatePassword(_authData.password);
    validateConfirmPassword(_authData.confirmPassword, _authData.password);
    isFormValidated.value = true;
  }

  RxBool loginEmailValidator = false.obs;
  RxBool loginPasswordValidator = false.obs;

  //validate Login email
  bool validateLoginEmail(String loginEmail) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    if (loginEmail.isEmpty) {
      emailError.value = 'Email is required';
      loginEmailValidator.value = false;
      return false;
    } else if (!emailRegex.hasMatch(loginEmail)) {
      emailError.value = 'Invalid email format';
      loginPasswordValidator.value = false;
      return false;
    } else {
      emailError.value = '';
      loginEmailValidator.value = true;
      return true;
    }
  }

  // validate Login password
  bool validateLoginPassword(String loginPassword) {
    // Password must be at least 8 characters long
    if (loginPassword.length < 8) {
      passwordError.value = 'Password must be at least 8 characters long';
      loginPasswordValidator.value = false;
      return false;
    }

    // Password must contain at least one uppercase letter
    if (!loginPassword.contains(RegExp(r'[A-Z]'))) {
      passwordError.value =
          'Password must contain at least one uppercase letter';
      return false;
    }

    // Password must contain at least one lowercase letter
    if (!loginPassword.contains(RegExp(r'[a-z]'))) {
      passwordError.value =
          'Password must contain at least one lowercase letter';

      return false;
    }

    // Password must contain at least one digit
    if (!loginPassword.contains(RegExp(r'[0-9]'))) {
      passwordError.value = 'Password must contain at least one digit';
      return false;
    }

    passwordError.value = '';
    loginPasswordValidator.value = true;
    return true;
  }

  //validate all field in login
  void validateLoginAll() {
    validateLoginEmail(_authData.loginEmail);
    validateLoginPassword(_authData.loginPassword);
    isLoginFormValidated.value = true;
  }
}
