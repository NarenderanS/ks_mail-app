import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ks_mail/src/utils/constants/icons.dart';
import '../../../utils/constants/styles.dart';

class UsernameWidget extends StatelessWidget {
  const UsernameWidget({
    super.key,required this.usernameController
  });
  final TextEditingController usernameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: usernameController,
        cursorColor: Colors.lightBlueAccent,
        // keyboardType: TextInputType.emailAddress,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please Enter some text";
          } else if (value.length < 4) {
            return "Username must be at least 4 characters long";
          }
          return null;
        },
        decoration: textFieldDecoration(AppLocalizations.of(context)!.username,
            profileIcon),
      ),
    );
  }
}
