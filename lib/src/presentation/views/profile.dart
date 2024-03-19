import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/presentation/riverpod/user_provider.dart';
import 'package:ks_mail/src/presentation/widgets/button_widgets/back_icon_button_widget.dart';
import 'package:ks_mail/src/presentation/widgets/circular_avatar_widgets/circular_avatar_widget.dart';
import 'package:ks_mail/src/utils/constants/icons.dart';
import 'package:ks_mail/src/utils/constants/styles.dart';

import '../../utils/constants/variables.dart';
import '../widgets/text_field_widgets/phone_no_widget.dart';
import '../widgets/text_field_widgets/username_widget.dart';
import '../widgets/text_widgets/display_text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static String id = "profile";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButtonWidget(),
        title: Text(AppLocalizations.of(context)!.profile),
      ),
      body: ListView(
        padding: safePadding,
        children: [
          ListTile(
              trailing: IconButton(
                  onPressed: () {
                    usernameController.text = currentUser!.username;
                    phoneNoController.text = currentUser!.phoneNo;
                    showDialog(
                        context: context,
                        builder: (context) {
                          return EdtProfileWidget(
                              usernameController: usernameController,
                              phoneNoController: phoneNoController);
                        });
                  },
                  icon: editIcon)),
          ListTile(
            title: CircularAvatarWidget(
              text: currentUser!.username[0],
              radius: 50,
              textSize: 40,
            ),
          ),
          DisplayTextWidget(
            defaultText: "${AppLocalizations.of(context)!.username}: ",
            text: currentUser!.username,
          ),
          DisplayTextWidget(
            defaultText: "${AppLocalizations.of(context)!.mail}: ",
            text: currentUser!.mail,
          ),
          DisplayTextWidget(
            defaultText: "${AppLocalizations.of(context)!.phoneNo}: ",
            text: currentUser!.phoneNo,
          ),
        ],
      ),
    );
  }
}

class EdtProfileWidget extends ConsumerWidget {
  const EdtProfileWidget({
    super.key,
    required this.usernameController,
    required this.phoneNoController,
  });

  final TextEditingController usernameController;
  final TextEditingController phoneNoController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Text(
        AppLocalizations.of(context)!.e_profile,
        style: const TextStyle(fontSize: 20),
      ),
      content: Wrap(
        children: [
          Form(
            child: Wrap(alignment: WrapAlignment.center, children: [
              UsernameWidget(
                usernameController: usernameController,
              ),
              PhoneNoWidget(phoneNoController: phoneNoController),
              // PasswordWidget(
              //     toggleText: AppLocalizations.of(context)!.password,
              //     passwordController: passwordController),
              // PasswordWidget(
              //     toggleText: AppLocalizations.of(context)!.c_password,
              //     passwordController: cPasswordController)
              OutlinedButton(
                onPressed: () async {
                  await ref.read(userListNotifierProvider.notifier).updateUser(
                      username: usernameController.text,
                      phoneNo: phoneNoController.text);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                style: buttonStyle,
                child: Text(AppLocalizations.of(context)!.update),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
