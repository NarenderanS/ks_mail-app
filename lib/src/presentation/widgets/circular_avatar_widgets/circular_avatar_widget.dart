import 'package:flutter/material.dart';
import 'package:ks_mail/src/utils/constants/colors.dart';

class CircularAvatarWidget extends StatelessWidget {
  const CircularAvatarWidget(
      {super.key, this.text, this.profilePicture, this.radius, this.textSize});

  final String? text;
  final String? profilePicture;
  final double? radius;
  final double? textSize;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: blue200,
      child: Text(
        text ?? "",
        style: TextStyle(fontSize: textSize),
      ),
    );
  }
}
