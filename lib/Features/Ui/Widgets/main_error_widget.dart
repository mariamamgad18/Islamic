import 'package:flutter/material.dart';

class MainErrorWidget extends StatelessWidget {
  VoidCallback? onPressed;
  final String errorMsg;

  MainErrorWidget({super.key, required this.errorMsg, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          errorMsg,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
        ),
        //todo: الزرار ده مش دايما هيظهر
        onPressed != null
            ? ElevatedButton(
              onPressed: onPressed,
              child: Text(
                'Try again',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
            : Container(),
      ],
    );
  }
}
