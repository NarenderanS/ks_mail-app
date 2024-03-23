import 'package:flutter/material.dart';

class IconButtonWithText extends StatelessWidget {
  const IconButtonWithText({super.key, required this.icon, required this.text});
  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {},
          icon: icon,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        Text(text)
      ],
    );
  }
}
