import 'package:flutter/material.dart';
import 'package:ks_mail/src/utils/constants/styles.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key,
      required this.color,
      required this.text,
      required this.onPressed});
  final Color color;
  final String text;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            padding: MaterialStateProperty.all(
              const EdgeInsets.all(20),
            ),
            alignment: Alignment.center),
        child: Text(
          text,
          style: textWhite.copyWith(fontSize: 20),
        ),
      ),
    );
  }
}
