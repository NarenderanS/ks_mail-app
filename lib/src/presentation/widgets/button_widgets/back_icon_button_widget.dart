import 'package:flutter/material.dart';

class BackIconButtonWidget extends StatelessWidget {
  const BackIconButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back),
    );
  }
}