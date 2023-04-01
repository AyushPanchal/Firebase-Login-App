import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:login_app_firebase/controllers/authentication_controllers/auth_controller.dart';
import 'package:login_app_firebase/models/user_model.dart';

class FirestoreController extends GetxController {
  final _firestoreDb = FirebaseFirestore.instance;
  final AuthController _authController = Get.find();
  final String userId = 'ld4lpc7u0xMwiEFcRj3f';

  Stream<User?> getData() {
    try {
      return FirebaseFirestore.instance
          .collection('User')
          .where('id', isEqualTo: userId)
          .snapshots()
          .map(
        (querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            return User.fromJson(querySnapshot.docs.first.data());
          } else {
            return null;
          }
        },
      );
    } catch (e) {
      print('Error fetching user data: $e');
      return Stream.empty();
    }
  }
}
