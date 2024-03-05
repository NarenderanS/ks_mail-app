import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ks_mail/src/utils/constants/icons.dart';
import '../../../utils/constants/constant.dart';
import '../../../utils/text_field_controllers.dart';

class EmailWidget extends StatelessWidget {
  const EmailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: mailController,
        cursorColor: Colors.lightBlueAccent,
        keyboardType: TextInputType.emailAddress,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          // Email validation using regular expression
          if (value!.isEmpty) {
            return 'Please enter an email address';
          } else if (!_isValidEmail(value)) {
            return 'Please enter a valid email address';
          }
          return null;
        },
        decoration:
            textFieldDecoration(AppLocalizations.of(context)!.mail, mailIcon),
      ),
    );
  }

  bool _isValidEmail(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }
}
