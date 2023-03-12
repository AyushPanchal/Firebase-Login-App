import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String textData;
  const CustomButton({Key? key, required this.textData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColours.componentsColor,
        borderRadius: BorderRadius.circular(50),
      ),
      height: 65,
      width: 230,
      child: Center(
        child: Text(
          textData,
          style: const TextStyle(
              color: AppColours.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
