import 'package:login_app_firebase/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:login_app_firebase/controllers/validation_controller.dart';
import 'package:login_app_firebase/controllers/auth_data_controller.dart';

void init() {
  Get.lazyPut(() => AuthDataController());
  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => ValidationController());
}
