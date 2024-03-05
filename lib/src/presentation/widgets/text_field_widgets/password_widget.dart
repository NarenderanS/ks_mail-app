import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ks_mail/src/utils/constants/icons.dart';
import '../../../utils/constants/constant.dart';
import '../../../utils/text_field_controllers.dart';

class PasswordWidget extends StatefulWidget {
  const PasswordWidget({
    super.key,
    required this.toggleText,
  });
  final String toggleText;

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool _show = true;
  void showPassword() {
    setState(() => _show = !_show);
  }

  @override
  Widget build(BuildContext context) {
    final bool isPasswordController =
        widget.toggleText == AppLocalizations.of(context)!.password;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller:
            isPasswordController ? passwordController : cPasswordController,
        cursorColor: Colors.lightBlueAccent,
        obscureText: _show,
        keyboardType: TextInputType.visiblePassword,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => isPasswordController
            ? passwordValidation(value)
            : confirmPasswordValidation(value),
        decoration: textFieldDecoration(
                isPasswordController
                    ? AppLocalizations.of(context)!.password
                    : AppLocalizations.of(context)!.c_password,
                passwordIcon)
            .copyWith(
          suffixIcon: IconButton(
              icon: Icon(_show ? Icons.visibility : Icons.visibility_off),
              onPressed: () => showPassword()),
        ),
      ),
    );
  }

  bool _isValidPassword(String password) {
    String passwordPattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regex = RegExp(passwordPattern);
    return regex.hasMatch(password);
  }

  passwordValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    } else if (!_isValidPassword(value)) {
      return 'Password must contain at least \none uppercase letter, \none lowercase letter, \none digit, \none special character';
    }
    return null;
  }

  confirmPasswordValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    } else if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
