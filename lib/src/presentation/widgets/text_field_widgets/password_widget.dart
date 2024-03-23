import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ks_mail/src/utils/constants/icons.dart';
import '../../../utils/constants/styles.dart';

class PasswordWidget extends StatefulWidget {
  const PasswordWidget(
      {super.key,
      required this.toggleText,
      required this.passwordController,
      this.cPasswordController});
  final String toggleText;
  final TextEditingController passwordController;
  final TextEditingController? cPasswordController;

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
          controller: isPasswordController
              ? widget.passwordController
              : widget.cPasswordController,
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
        ));
  }

  bool _isValidPassword(String password) {
    String passwordPattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regex = RegExp(passwordPattern);
    return regex.hasMatch(password);
  }

  passwordValidation(String? value) {
    if (value!.isEmpty) {
      return AppLocalizations.of(context)!.empty_password;
    } else if (value.length < 6) {
      return AppLocalizations.of(context)!.password_length;
    } else if (!_isValidPassword(value)) {
      return AppLocalizations.of(context)!.password_condition;
    }
    return null;
  }

  confirmPasswordValidation(String? value) {
    if (value!.isEmpty) {
      return AppLocalizations.of(context)!.empty_password;
    } else if (value != widget.passwordController.text) {
      return AppLocalizations.of(context)!.password_match;
    }
    return null;
  }
}
