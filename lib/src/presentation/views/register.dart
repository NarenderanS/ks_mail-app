import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/presentation/riverpod/user_provider.dart';
import 'package:ks_mail/src/presentation/widgets/text_field_widgets/email_widget.dart';
import 'package:ks_mail/src/presentation/widgets/text_field_widgets/password_widget.dart';
import 'package:ks_mail/src/utils/constants/styles.dart';
import 'package:ks_mail/src/presentation/views/login.dart';

import '../../utils/constants/commom_functions.dart';
import '../widgets/button_widgets/rounded_button_widget.dart';
import '../widgets/text_widgets/link_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/text_field_widgets/phone_no_widget.dart';
import '../widgets/text_field_widgets/username_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static String id = "register";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerformKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

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
                  UsernameWidget(usernameController: usernameController),
                  PhoneNoWidget(phoneNoController: phoneNoController),
                  MailWidget(mailController: mailController),
                  PasswordWidget(
                      toggleText: AppLocalizations.of(context)!.password,
                      passwordController: passwordController),
                  PasswordWidget(
                    toggleText: AppLocalizations.of(context)!.c_password,
                    cPasswordController: cPasswordController,
                    passwordController: passwordController,
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
                        ref.read(userListNotifierProvider.notifier).addUser(
                            username: usernameController.text,
                            mail: mailController.text,
                            phoneNo: phoneNoController.text,
                            password: passwordController.text);
                        _resetRegisterForm();
                        snackBar(
                            context: context,
                            text:
                                AppLocalizations.of(context)!.register_success,
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
    mailController.text = '';
    passwordController.text = '';
    cPasswordController.text = '';
    phoneNoController.text = '';
    usernameController.text = '';
    _registerformKey.currentState!.reset();
  }
}
