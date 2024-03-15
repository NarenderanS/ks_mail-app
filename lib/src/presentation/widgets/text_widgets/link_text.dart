import 'package:flutter/material.dart';
import 'package:ks_mail/src/utils/constants/styles.dart';

class LinkText extends StatelessWidget {
  const LinkText(
      {super.key, required this.text, required this.textInLink, this.onTap});
  final String text;
  final String textInLink;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Text(text),
      InkWell(
        onTap: onTap,
        child:  Text(
          textInLink,
          style: linkText,
        ),
      )
    ]);
  }
}
