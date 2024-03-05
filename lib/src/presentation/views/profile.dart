import 'package:flutter/material.dart';
import 'package:ks_mail/src/presentation/widgets/button_widgets/back_icon_button_widget.dart';
import 'package:ks_mail/src/presentation/widgets/circular_avatar_widgets/circular_avatar_widget.dart';
import 'package:ks_mail/src/utils/constants/constant.dart';
import 'package:ks_mail/src/presentation/state_management/user.dart';

import '../widgets/text_field_widgets/password_widget.dart';
import '../widgets/text_field_widgets/phone_no_widget.dart';
import '../widgets/text_field_widgets/username_widget.dart';
import '../widgets/text_widgets/display_text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  static String id = "profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButtonWidget(),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: safePadding,
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10.0, left: 10),
              child: Text(
                "Profile",
                style: TextStyle(
                    color: Color.fromARGB(255, 33, 3, 3),
                    fontWeight: FontWeight.w700,
                    fontSize: 25),
              ),
            ),
            Column(
              // runAlignment: WrapAlignment.center,
              // alignment: WrapAlignment.spaceAround,
              // runSpacing: 30,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircularAvatarWidget(
                  text: currentUser!.username[0],
                  radius: 60,
                  textSize: 60,
                ),
                const SizedBox(
                  height: 30,
                ),
                Wrap(
                  runSpacing: 10,
                  alignment: WrapAlignment.start,
                  children: [
                    DisplayTextWidget(
                      defaultText: "Username: ",
                      text: currentUser!.username,
                    ),
                    DisplayTextWidget(
                      defaultText: "Mail: ",
                      text: currentUser!.mail,
                    ),
                    DisplayTextWidget(
                      defaultText: "PhoneNo: ",
                      text: currentUser!.phoneNo,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> updateProfile(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 219, 234, 240),
            content: Wrap(
              children: [
                Text(
                  "Update $text",
                  style: textStyle,
                ),
                Form(
                  child: Wrap(alignment: WrapAlignment.center, children: [
                    const UsernameWidget(),
                    const PhoneNoWidget(),
                    PasswordWidget(
                        toggleText: AppLocalizations.of(context)!.password),
                    PasswordWidget(
                      toggleText: AppLocalizations.of(context)!.c_password,
                    )
                  ]),
                ),
              ],
            ),
          );
        });
  }
}
// Align(
//                     alignment: Alignment.centerRight,
//                     child: Icon(
//                       Icons.edit_outlined,
//                       color: Color.fromARGB(255, 33, 3, 3),
//                       size: 30,
//                     ),
//                   ),