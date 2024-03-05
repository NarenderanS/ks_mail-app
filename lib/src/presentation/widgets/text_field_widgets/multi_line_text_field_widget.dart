import 'package:flutter/material.dart';

class MultiLineTextFieldWidget extends StatelessWidget {
  const MultiLineTextFieldWidget(
      {super.key, required this.controller, required this.hintText});

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.white,
          border: InputBorder.none),
      scrollPadding: const EdgeInsets.all(10),
      keyboardType: TextInputType.multiline,
      minLines: 10,
      maxLines: 999,
    );
  }
}
