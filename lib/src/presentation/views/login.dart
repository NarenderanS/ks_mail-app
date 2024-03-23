import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/presentation/riverpod/mail_provider.dart';
import 'package:ks_mail/src/presentation/riverpod/user_provider.dart';
import 'package:ks_mail/src/utils/constants/styles.dart';
import 'package:ks_mail/src/presentation/views/home.dart';
import 'package:ks_mail/src/presentation/views/register.dart';
import 'package:ks_mail/src/presentation/widgets/button_widgets/rounded_button_widget.dart';
import 'package:ks_mail/src/presentation/widgets/text_widgets/link_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ks_mail/src/utils/constants/variables.dart';
import '../../utils/constants/commom_functions.dart';
import '../widgets/text_field_widgets/email_widget.dart';
import '../widgets/text_field_widgets/password_widget.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  static String id = "login";
  final _loginformKey = GlobalKey<FormState>();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        padding: safePadding,
        child: Center(
          child: ListView(shrinkWrap: true, children: [
            Text(
              AppLocalizations.of(context)!.login,
              style: textStyle,
            ),
            //Form text fields
            Form(
              key: _loginformKey,
              child: Wrap(children: [
                MailWidget(
                  mailController: mailController,
                ),
                PasswordWidget(
                  toggleText: AppLocalizations.of(context)!.password,
                  passwordController: passwordController,
                ),
              ]),
            ),
            // Login Button
            Button(
                color: const Color.fromARGB(255, 124, 212, 23),
                text: AppLocalizations.of(context)!.login,
                onPressed: () async {
                  if (_loginformKey.currentState!.validate() &&
                      await ref
                          .read(userListNotifierProvider.notifier)  
                          .validateUser(
                              mail: mailController.text,
                              password: passwordController.text) &&
                      currentUser != null) {
                    await ref
                        .read(userListNotifierProvider.notifier)
                        .getAllUsers();
                    await ref
                        .read(mailListNotifierProvider.notifier)
                        .getMailsFromDB();
                    if (context.mounted) {
                      snackBar(
                          context: context,
                          text: AppLocalizations.of(context)!.login_success,
                          color: Colors.green);

                      _clearRegisterForm();

                      Navigator.pushNamedAndRemoveUntil(
                          context, HomePage.id, (route) => false);
                    }
                  } else {
                    if (context.mounted) {
                      snackBar(
                          context: context,
                          text: AppLocalizations.of(context)!
                              .invalid_credentials);
                    }
                  }
                }),

            LinkText(
              text: AppLocalizations.of(context)!.account_need,
              textInLink: AppLocalizations.of(context)!.register,
              onTap: () {
                _clearRegisterForm();
                Navigator.pushNamedAndRemoveUntil(
                    context, RegisterPage.id, (route) => false);
              },
            ),
          ]),
        ),
      ),
    );
  }

  void _clearRegisterForm() {
    mailController.text = '';
    passwordController.text = '';
    _loginformKey.currentState!.reset();
  }
}
