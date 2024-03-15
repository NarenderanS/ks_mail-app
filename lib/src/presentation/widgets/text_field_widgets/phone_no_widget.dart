import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ks_mail/src/utils/constants/icons.dart';
import '../../../utils/constants/styles.dart';

class PhoneNoWidget extends StatelessWidget {
  const PhoneNoWidget({
    super.key,
    required this.phoneNoController,
  });
  final TextEditingController phoneNoController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: phoneNoController,
        cursorColor: Colors.lightBlueAccent,
        keyboardType: TextInputType.phone,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please Enter Phone Number";
          } else if (!_isValidPhoneNumber(value)) {
            return 'Enter a valid phone number';
          }
          return null;
        },
        decoration: textFieldDecoration(
            AppLocalizations.of(context)!.phoneNo, phoneIcon),
      ),
    );
  }

  bool _isValidPhoneNumber(String phoneNo) {
    RegExp phoneNoPattern = RegExp(r'^[+]?[0-9]{10,15}$');
    return phoneNoPattern.hasMatch(phoneNo);
  }
}
