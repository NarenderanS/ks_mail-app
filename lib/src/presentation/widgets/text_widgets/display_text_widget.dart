import 'package:flutter/material.dart';

class DisplayTextWidget extends StatelessWidget {
  const DisplayTextWidget(
      {super.key, required this.defaultText, required this.text});
  final String defaultText;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Text(
          defaultText,
          style: const TextStyle(fontSize: 20),
        ),
        title: Text(
          text,
          style: const TextStyle(fontSize: 22),
        ));
  }
}
