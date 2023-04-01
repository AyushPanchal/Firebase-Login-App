import 'package:flutter/material.dart';
import 'package:login_app_firebase/controllers/authentication_controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../constants/dimensions.dart';

class LoadingWidget extends StatelessWidget {
  final authController = Get.find<AuthController>();
  LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: authController.isLoading.value
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 40),
              decoration: BoxDecoration(
                  color: AppColours.inactiveColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(
                    color: AppColours.componentsColor,
                    backgroundColor: AppColours.activeColor,
                  ),
                  SizedBox(
                    height: Dimensions.h20,
                  ),
                  Text(
                    'Loading...',
                    style:
                        TextStyle(color: AppColours.activeColor, fontSize: 16),
                  )
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
