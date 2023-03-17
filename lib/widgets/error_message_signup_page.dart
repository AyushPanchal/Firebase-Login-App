import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final bool visibleCondition;
  final String errorMessage;
  const ErrorMessage(
      {Key? key, required this.visibleCondition, required this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 5),
      child: Visibility(
        maintainSize: false,
        maintainState: true,
        visible: visibleCondition,
        child: Text(
          errorMessage,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
