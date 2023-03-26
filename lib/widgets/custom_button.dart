import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String textData;
  Color? textDataColor;
  Color? backgroundColor;
  CustomButton({
    Key? key,
    required this.textData,
    this.backgroundColor = AppColours.componentsColor,
    this.textDataColor = AppColours.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(50),
      ),
      height: 65,
      width: double.infinity,
      child: Center(
        child: Text(
          textData,
          style: TextStyle(
              color: textDataColor, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
