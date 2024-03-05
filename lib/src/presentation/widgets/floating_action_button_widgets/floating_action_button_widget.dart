import 'package:flutter/material.dart';
import 'package:ks_mail/src/presentation/views/new_mail.dart';
import 'package:ks_mail/src/utils/constants/icons.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NewMailPage.id);
        },
        child: editIcon);
  }
}
