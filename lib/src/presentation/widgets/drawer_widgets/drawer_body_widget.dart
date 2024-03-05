import 'package:flutter/material.dart';

class DrawerBodyContent extends StatelessWidget {
  const DrawerBodyContent(
      {super.key,
      required this.text,
      required this.icon,
      required this.onTap,
      this.isSelected});
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,
          color: isSelected ?? false ? Colors.black : Colors.grey.shade600),
      title: Text(
        text,
        style: TextStyle(
            color: isSelected ?? false ? Colors.black : Colors.grey.shade600),
      ),
      onTap: onTap,
      selected: isSelected ?? false,
    );
  }
}
