import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:login_app_firebase/controllers/authentication_controllers/auth_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(_authController.currentUser.value!.uid),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await _authController.logoutUser();
              },
              child: const Text('Sign out'),
            ),
          ),
        ],
      ),
    );
  }
}
