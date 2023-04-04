import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:login_app_firebase/controllers/authentication_controllers/auth_controller.dart';
import 'package:login_app_firebase/models/user_model.dart';

/*=====FirestoreController will handle all the firestore related operations====*/
class FirestoreController extends GetxController {
  final _firestoreDb = FirebaseFirestore.instance;

  /*=====
  AuthController to access the user's uid ,
  uid will be used as a document id in firestore database
  =====*/
  final AuthController _authController = Get.find();

  /*=====
  Get the user data from the database,
  this method returns stream of User ,
  which listens to the database concurrently if changes are mage
  ===== */
  Stream<User?> getData() {
    try {
      return _firestoreDb
          .collection('User')
          .where('id', isEqualTo: _authController.currentUser.value!.uid)
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
      return const Stream.empty();
    }
  }

  /*=====This method is adds a User to database when the user gets registered =====*/
  Future<void> addUserDataOfRegistrationPageToFirestore(User user) async {
    try {
      await _firestoreDb
          .collection('User')
          .doc(_authController.currentUser.value!.uid)
          .set(user.toJson());
    } catch (e) {
      print('Error adding user to Firestore: $e');
    }
  }

  /*=====This method is updates users additional info after user successfully gets registered=====*/
  Future<void> updateUserDataOfRegistrationPageToFirestore(User user) async {
    try {
      print(user.id);
      final documentSnapshot =
          await _firestoreDb.collection('User').doc(user.id).get();
      if (documentSnapshot.exists) {
        await _firestoreDb
            .collection('User')
            .doc(user.id)
            .update(user.toJson());
      } else {
        print('Error updating user in Firestore: Document does not exist');
      }
    } catch (e) {
      print('Error updating user in Firestore: $e');
    }
  }
}
