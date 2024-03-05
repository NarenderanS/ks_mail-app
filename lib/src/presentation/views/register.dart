import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/presentation/widgets/text_field_widgets/email_widget.dart';
import 'package:ks_mail/src/presentation/widgets/text_field_widgets/password_widget.dart';
import 'package:ks_mail/src/utils/constants/constant.dart';
import 'package:ks_mail/src/presentation/views/login.dart';
import 'package:ks_mail/src/presentation/state_management/user.dart';

import '../../utils/constants/commom_functions.dart';
import '../../utils/text_field_controllers.dart';
import '../widgets/button_widgets/rounded_button_widget.dart';
import '../widgets/text_widgets/link_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/text_field_widgets/phone_no_widget.dart';
import '../widgets/text_field_widgets/username_widget.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  static String id = "register";
  final _registerformKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: safePadding,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                AppLocalizations.of(context)!.register,
                style: textStyle,
              ),
              Form(
                key: _registerformKey,
                child: Wrap(alignment: WrapAlignment.center, children: [
                  const UsernameWidget(),
                  const PhoneNoWidget(),
                  const EmailWidget(),
                  PasswordWidget(
                      toggleText: AppLocalizations.of(context)!.password),
                  PasswordWidget(
                    toggleText: AppLocalizations.of(context)!.c_password,
                  )
                ]),
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return Button(
                    color: const Color.fromARGB(217, 18, 225, 125),
                    text: AppLocalizations.of(context)!.register,
                    onPressed: () {
                      if (_registerformKey.currentState!.validate()) {
                        ref.read(userProvider.notifier).addUser(
                            username: usernameController.text,
                            mail: mailController.text,
                            phoneNo: phoneNoController.text,
                            password: passwordController.text);
                        _resetRegisterForm();
                        snakeBar(
                            context: context,
                            text: "User registered successfully",
                            color: Colors.green.shade600);
                        Navigator.pushNamed(context, LoginPage.id);
                      }
                    },
                  );
                },
              ),
              LinkText(
                text: AppLocalizations.of(context)!.have_account,
                textInLink: AppLocalizations.of(context)!.login,
                onTap: () {
                  _resetRegisterForm();
                  Navigator.pushNamed(context, LoginPage.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _resetRegisterForm() {
    _registerformKey.currentState!.reset();
  }
}
