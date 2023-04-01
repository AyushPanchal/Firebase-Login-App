import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:login_app_firebase/constants/exports_constants.dart';
import 'package:login_app_firebase/controllers/authentication_controllers/auth_controller.dart';
import 'package:login_app_firebase/controllers/firebase_storage_controllers/storage_controller.dart';
import 'package:login_app_firebase/controllers/firestore_controllers/firestore_controllers.dart';
import 'package:login_app_firebase/controllers/model_controllers/user_model_controller.dart';

import '../../models/user_model.dart';

class UserDataPage extends StatefulWidget {
  static const String id = 'user_model_screen_id';
  const UserDataPage({Key? key}) : super(key: key);

  @override
  State<UserDataPage> createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {
  final UserModelController _userModelController = Get.find();
  final AuthController _authController = Get.find();
  final StorageController _storageController = Get.find();
  final FirestoreController _firestoreController = Get.find();
  File? imageFile;
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
        elevation: 0,
        backgroundColor: AppColours.primaryColor,
      ),
      body: SingleChildScrollView(
        reverse: true,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            StreamBuilder<User?>(
              stream: _firestoreController.getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  DateTime date = snapshot.data!.dateOfBirth!;
                  String dateFormat =
                      "${date.day} / ${date.month} / ${date.year}";
                  return GestureDetector(
                    onTap: () async {
                      var temp = await _userModelController.pickAndCropImage();
                      setState(() {
                        imageFile = temp;
                      });
                      await _storageController
                          .uploadImageToFirebaseStorage(temp!);
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          foregroundImage:
                              NetworkImage(snapshot.data!.profilePictureURL!),
                          radius: 50,
                        ),
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: AppColours.inactiveColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Icon(
                                Icons.add_a_photo,
                                color: AppColours.componentsColor,
                                size: 20,
                              ),
                            ))
                      ],
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () async {
                      var temp = await _userModelController.pickAndCropImage();
                      setState(() {
                        imageFile = temp;
                      });
                      await _storageController
                          .uploadImageToFirebaseStorage(temp!);
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          foregroundImage:
                              AssetImage('assets/images/default_profile.jpg'),
                          radius: 50,
                        ),
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: AppColours.inactiveColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Icon(
                                Icons.add_a_photo,
                                color: AppColours.componentsColor,
                                size: 20,
                              ),
                            ))
                      ],
                    ),
                  );
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                _authController.logoutUser();
              },
              child: const Text('Press me/logout'),
            ),
            StreamBuilder<User?>(
                stream: _firestoreController.getData(),
                builder: (context, snapshot) {
                  return Text('hello');
                })
          ],
        ),
      ),
    );
  }
}
