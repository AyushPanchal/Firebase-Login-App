import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_app_firebase/models/user_model.dart';
import '../../helper/remote_services.dart';
import '../authentication_controllers/auth_data_controller.dart';

class UserModelController extends GetxController {
  static UserModelController get instance => Get.find();

  final _authDataController = Get.find<AuthDataController>();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController profilePictureURLController =
      TextEditingController();

  RxString get city => cityController.text.obs;
  RxString get state => stateController.text.obs;
  RxString get country => countryController.text.obs;
  RxString get zipCode => zipCodeController.text.obs;
  RxString get dateOfBirth => dateOfBirthController.text.obs;
  RxString get gender => genderController.text.obs;
  RxString get profilePictureURL => profilePictureURLController.text.obs;

  User get user {
    return User(
      fullName: _authDataController.fullName,
      email: _authDataController.email,
      phoneNumber: _authDataController.phoneNumber,
      city: city.value,
      state: state.value,
      country: country.value,
      zipCode: zipCode.value,
      dateOfBirth: dateOfBirth.value as DateTime,
      gender: gender.value,
      profilePictureURL: profilePictureURL.value,
    );
  }

  /*=====Method to pick and crop profile image=====*/
  Future<File?> pickAndCropImage() async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final croppedFile = await ImageCropper().cropImage(
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

  Future<void> getLocation() async {
    await RemoteServices().getCountryStateCityByLatLong();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != DateTime.now()) {
      // dateOfBirthController.clear();
      dateOfBirthController.text =
          '${picked.day}-${picked.month}-${picked.year}';
    } else {
      // dateOfBirthController.clear();
      dateOfBirthController.text =
          '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
    }
  }

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
