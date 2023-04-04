import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:login_app_firebase/constants/exports_constants.dart';
import 'package:login_app_firebase/controllers/authentication_controllers/auth_controller.dart';
import 'package:login_app_firebase/controllers/firebase_storage_controllers/storage_controller.dart';
import 'package:login_app_firebase/controllers/firestore_controllers/firestore_controllers.dart';
import 'package:login_app_firebase/controllers/model_controllers/user_model_controller.dart';
import 'package:login_app_firebase/widgets/custom_text_field.dart';
import '../../models/user_model.dart';
import 'package:country_icons/country_icons.dart';

class UserDataPage extends StatefulWidget {
  static const String id = 'user_model_screen_id';
  const UserDataPage({Key? key}) : super(key: key);

  @override
  State<UserDataPage> createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {
  final _formKey = GlobalKey<FormState>();
  final UserModelController _userModelController = UserModelController.instance;
  final AuthController _authController = Get.find();
  final StorageController _storageController = Get.find();
  final FirestoreController _firestoreController = Get.find();
  File? imageFile;
  bool isMaleSelected = true;
  @override
  void initState() {
    // TODO: implement initState
    _userModelController.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {},
        ),
        title: const Text('Set Profile'),
        elevation: 0,
        backgroundColor: AppColours.primaryColor,
      ),
      body: SingleChildScrollView(
        reverse: true,
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: Dimensions.h20,
                ),

                /*=====Profile Image=====*/
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      File? image =
                          await _userModelController.pickAndCropImage();
                      image != null
                          ? _storageController
                              .uploadImageToFirebaseStorage(image)
                              .then(
                              (value) {
                                setState(
                                  () {
                                    imageFile = image;
                                  },
                                );
                              },
                            )
                          : null;
                    },
                    child: Stack(
                      children: [
                        StreamBuilder<User?>(
                            stream: _firestoreController.getData(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot
                                      .data!.profilePictureURL!.isNotEmpty) {
                                return CircleAvatar(
                                  foregroundImage: NetworkImage(
                                      snapshot.data!.profilePictureURL!),
                                  radius: 50,
                                );
                              } else {
                                return imageFile != null
                                    ? CircleAvatar(
                                        foregroundImage: FileImage(imageFile!),
                                        radius: 50,
                                      )
                                    : const CircleAvatar(
                                        foregroundImage: AssetImage(
                                          'assets/images/default_profile.jpg',
                                        ),
                                        radius: 50,
                                      );
                              }
                            }),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: AppColours.inactiveColor.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                            ),
                            child: const Icon(
                              Icons.edit_rounded,
                              color: AppColours.componentsColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: Dimensions.h20 * 2,
                ),

                /*=====Personal Info Text=====*/
                const Text(
                  'Personal Info',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColours.componentsColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: Dimensions.h20,
                ),

                /*=====Gender selection=====*/
                const Text(
                  'Select your gender',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColours.inactiveColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: Dimensions.h10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.h15,
                          ),
                          primary: isMaleSelected
                              ? AppColours.primaryColor
                              : AppColours.componentsColor,
                          backgroundColor: isMaleSelected
                              ? AppColours.componentsColor
                              : Colors.transparent,
                          side: const BorderSide(
                              color: AppColours.componentsColor),
                        ),
                        onPressed: () {
                          // _authController.logoutUser();
                          _userModelController.genderController.text = 'male';
                          setState(() {
                            isMaleSelected = true;
                          });
                        },
                        child: const Text('Male'),
                      ),
                    ),
                    const SizedBox(
                      width: Dimensions.h10,
                    ),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.h15,
                          ),
                          backgroundColor: isMaleSelected
                              ? Colors.transparent
                              : AppColours.componentsColor,
                          primary: isMaleSelected
                              ? AppColours.componentsColor
                              : AppColours.primaryColor,
                          side: const BorderSide(
                            color: AppColours.componentsColor,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isMaleSelected = false;
                            _userModelController.genderController.text =
                                'female';
                          });
                        },
                        child: const Text('Female'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: Dimensions.h20,
                ),

                /*=====Birth date=====*/
                CustomTextField(
                  onTap: () {
                    _userModelController.selectDate(context);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Birth date is required.';
                    }
                  },
                  readOnly: true,
                  controller: _userModelController.dateOfBirthController,
                  fillColor: AppColours.inactiveColor.withOpacity(0.7),
                  prefixIcon: Icons.calendar_month_rounded,
                  hintText: "Birth date",
                ),
                const SizedBox(
                  height: Dimensions.h20,
                ),

                /*=====Zip code=====*/
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    }

                    final RegExp zipCodeRegex = RegExp(r'^\d{6}$');

                    if (!zipCodeRegex.hasMatch(value)) {
                      return 'Invalid zip code format.';
                    }

                    return null;
                  },
                  controller: _userModelController.zipCodeController,
                  fillColor: AppColours.inactiveColor.withOpacity(0.7),
                  prefixIcon: Icons.location_on_rounded,
                  hintText: "Zip code (Optional)",
                ),
                const SizedBox(
                  height: Dimensions.h20,
                ),

                /*=====Country=====*/
                CustomTextField(
                  controller: _userModelController.countryController,
                  fillColor: AppColours.inactiveColor.withOpacity(0.7),
                  prefixIcon: Icons.flag_rounded,
                  hintText: "Country (Optional)",
                ),
                const SizedBox(
                  height: Dimensions.h20,
                ),

                /*=====State=====*/
                CustomTextField(
                  controller: _userModelController.stateController,
                  fillColor: AppColours.inactiveColor.withOpacity(0.7),
                  prefixIcon: Icons.location_on_rounded,
                  hintText: "State (Optional)",
                ),
                const SizedBox(
                  height: Dimensions.h20,
                ),

                /*=====City=====*/
                CustomTextField(
                  controller: _userModelController.cityController,
                  fillColor: AppColours.inactiveColor.withOpacity(0.7),
                  prefixIcon: Icons.location_city_rounded,
                  hintText: "City (Optional)",
                ),
                const SizedBox(
                  height: Dimensions.h15,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.h15,
                        ),
                        primary: AppColours.componentsColor,
                        onPrimary: AppColours.primaryColor,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _firestoreController
                              .updateUserDataOfRegistrationPageToFirestore(
                                  _userModelController.user);
                        }
                      },
                      child: const Text('SUBMIT')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
