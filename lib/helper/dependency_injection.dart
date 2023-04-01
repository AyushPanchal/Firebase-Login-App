import 'package:login_app_firebase/controllers/authentication_controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:login_app_firebase/controllers/authentication_controllers/validation_controller.dart';
import 'package:login_app_firebase/controllers/authentication_controllers/auth_data_controller.dart';
import '../controllers/firebase_storage_controllers/storage_controller.dart';
import '../controllers/firestore_controllers/firestore_controllers.dart';
import '../controllers/model_controllers/user_model_controller.dart';

void init() async {
  Get.lazyPut(() => AuthDataController(), fenix: true);
  Get.lazyPut(() => AuthController(), fenix: true);
  Get.lazyPut(() => ValidationController(), fenix: true);
  Get.lazyPut(() => UserModelController(), fenix: true);
  Get.lazyPut(
    () => StorageController(),
    fenix: true,
  );
  Get.lazyPut(() => FirestoreController(), fenix: true);
}
