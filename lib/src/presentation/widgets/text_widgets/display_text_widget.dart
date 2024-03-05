import 'package:flutter/material.dart';

class DisplayTextWidget extends StatelessWidget {
  const DisplayTextWidget(
      {super.key, required this.defaultText, required this.text});
  final String defaultText;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // alignment: WrapAlignment.end,
      // runAlignment: WrapAlignment.center,
      // runSpacing: 70,
      // spacing: 10 ,
      children: [
        Text(
          defaultText,
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
