import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/utils/constants/constant.dart';
import 'package:ks_mail/src/presentation/views/home.dart';
import 'package:ks_mail/src/presentation/views/register.dart';
import 'package:ks_mail/src/presentation/widgets/button_widgets/rounded_button_widget.dart';
import 'package:ks_mail/src/presentation/widgets/text_widgets/link_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ks_mail/src/presentation/state_management/user.dart';
import '../../utils/constants/commom_functions.dart';
import '../../utils/text_field_controllers.dart';
import '../widgets/text_field_widgets/email_widget.dart';
import '../widgets/text_field_widgets/password_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  static String id = "login";
  final _loginformKey = GlobalKey<FormState>();

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
                  AppLocalizations.of(context)!.login,
                  style: textStyle,
                ),
                //Form text fields
                Form(
                  key: _loginformKey,
                  child: Wrap(children: [
                    const EmailWidget(),
                    PasswordWidget(
                      toggleText: AppLocalizations.of(context)!.password,
                    ),
                  ]),
                ),
                // Login Button
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    return Button(
                        color: const Color.fromARGB(255, 124, 212, 23),
                        text: AppLocalizations.of(context)!.login,
                        onPressed: () {
                          // print(
                          //     "Login\n${mailController.text}\n${passwordController.text}");
                          // print(ref.read(userProvider.notifier).validateUser(
                          //     mailController.text, passwordController.text));
                          if (_loginformKey.currentState!.validate() &&
                              ref.read(userProvider.notifier).validateUser(
                                  mailController.text,
                                  passwordController.text)) {
                            // //Set currentUser knownMails
                            // currentUser.knownMails = ref
                            //     .read(mailListProvider.notifier)
                            //     .getUserKnownMails(currentUser.mail);
                            snakeBar(
                                context: context,
                                text: "Logined Successfully",
                                color: Colors.green);
                            _clearRegisterForm();

                            Navigator.popAndPushNamed(
                              context,
                              HomePage.id,
                            );
                          } else {
                            snakeBar(
                                context: context, text: "Invalid Credentials");
                          }
                        });
                  },
                ),

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
    _loginformKey.currentState!.reset();
  }
}


