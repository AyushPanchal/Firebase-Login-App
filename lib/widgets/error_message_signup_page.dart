import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final bool visibleCondition;
  final errorMessage;
  const ErrorMessage(
      {Key? key, required this.visibleCondition, this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      maintainSize: false,
      maintainState: true,
      visible: visibleCondition,
      child: Text(errorMessage),
    );
  }
}
