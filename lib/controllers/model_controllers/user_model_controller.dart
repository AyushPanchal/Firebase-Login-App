import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_app_firebase/controllers/authentication_controllers/auth_controller.dart';
import 'package:login_app_firebase/models/user_model.dart';
import '../../constants/colors.dart';
import '../../helper/remote_services.dart';
import '../authentication_controllers/auth_data_controller.dart';

/*=====UserModelController will handle, all the operations to retrieve all the data of the user=====*/
class UserModelController extends GetxController {
  static UserModelController get instance => Get.find();

  final _authDataController = Get.find<AuthDataController>();
  final _authController = Get.find<AuthController>();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController genderController =
      TextEditingController(text: 'male');
  final TextEditingController profilePictureURLController =
      TextEditingController();

  RxString get city => cityController.text.obs;
  RxString get state => stateController.text.obs;
  RxString get country => countryController.text.obs;
  RxString get zipCode => zipCodeController.text.obs;
  RxString get dateOfBirth => dateOfBirthController.text.obs;
  RxString get gender => genderController.text.obs;
  RxString get profilePictureURL => profilePictureURLController.text.obs;
  DateTime createAt = DateTime.now();
  DateTime userDOB = DateTime.now();

  User get user {
    List<String> dateList = dateOfBirthController.text.split('-');
    return User(
      id: _authController.currentUser.value!.uid,
      fullName: _authDataController.fullName,
      email: _authDataController.emailOrPhoneNumber.contains('@')
          ? _authDataController.emailOrPhoneNumber
          : '',
      phoneNumber: !_authDataController.emailOrPhoneNumber.contains('@')
          ? _authDataController.emailOrPhoneNumber
          : '',
      city: city.value,
      state: state.value,
      country: country.value,
      zipCode: zipCode.value,
      dateOfBirth: userDOB,
      gender: gender.value,
      profilePictureURL: profilePictureURL.value,
      createdAt: createAt,
    );
  }

  /*=====
  Method to pick and crop profile image
  =====*/
  Future<File?> pickAndCropImage() async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final croppedFile = await ImageCropper().cropImage(
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: AppColours.componentsColor,
          )
        ],
        sourcePath: pickedImage.path,
        compressQuality: 100,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
      );
      return File(croppedFile!.path);
    }
    return null;
  }

  /*=====This method will fetch the current location of thw user=====*/
  Future<void> getLocation() async {
    await RemoteServices().getCountryStateCityByLatLong();
  }

  /*=====
   This method will show the datePicker when the user taps,
   on the date of birth field in UserDataPage,
   when user selects the date it will show the date to the TextFormField ,
   and also user's dateOfBirth will also get updated accordingly.
   =====*/
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != DateTime.now()) {
      // dateOfBirthController.clear();
      userDOB = picked;
      dateOfBirthController.text =
          '${picked.day}-${picked.month}-${picked.year}';
    } else {
      // dateOfBirthController.clear();
      dateOfBirthController.text =
          '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
    }
  }

  /*=====Method to clear all the controllers at once.=====*/
  void clearAllControllers() {
    cityController.clear();
    stateController.clear();
    countryController.clear();
    zipCodeController.clear();
    dateOfBirthController.clear();
    genderController.clear();
    profilePictureURLController.clear();
  }
}
