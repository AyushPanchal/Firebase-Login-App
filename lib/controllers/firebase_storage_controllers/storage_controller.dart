import 'dart:io';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app_firebase/controllers/authentication_controllers/auth_controller.dart';
import 'package:login_app_firebase/controllers/model_controllers/user_model_controller.dart';

class StorageController extends GetxController {
  final AuthController _authController = Get.find();
  final UserModelController _userModelController = Get.find();
  final _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      // Get the current user's unique ID
      final User? user = _authController.currentUser.value;
      final String uid = user!.uid;

      // Create a reference to the folder for this user's images
      final Reference storageRef = _firebaseStorage.ref().child(uid);

      // Create a timestamp to use as the image's filename
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Create a reference to the image file in Firebase Storage
      final Reference imageRef = storageRef.child(fileName);

      // Upload the image file to Firebase Storage
      final UploadTask uploadTask = imageRef.putFile(imageFile);

      // Wait for the upload to complete and return the image's download URL
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      _userModelController.profilePictureURLController.text = downloadUrl;
      return downloadUrl;
    } on FirebaseException catch (e) {
      // Handle any Firebase related errors
      print('Firebase error: ${e.code}');
      throw e;
    } on Exception catch (e) {
      // Handle any other type of exception
      print('Error: $e');
      throw e;
    }
  }
}
