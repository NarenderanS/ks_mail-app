import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/domain/entities/user_details.dart';

import '../../state_management/mail_list.dart';
import '../../../utils/constants/commom_functions.dart';
import '../../../utils/constants/constant.dart';
import '../../views/home.dart';

class SendMailButtonWidget extends StatelessWidget {
  const SendMailButtonWidget({
    super.key,
    required this.toList,
    required this.ccList,
    required this.bccList,
    required this.ref,
    required this.idValue,
    required this.subjectController,
    required this.bodyController,
  });

  final List<UserDetails> toList;
  final List<UserDetails> ccList;
  final List<UserDetails> bccList;
  final WidgetRef ref;
  final int idValue;
  final TextEditingController subjectController;
  final TextEditingController bodyController;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          // toControllerList = ["test2@kumaran.com"];
          if ((toList.isNotEmpty || ccList.isNotEmpty || bccList.isNotEmpty) &&
              (bodyController.text.isNotEmpty &&
                  subjectController.text.isNotEmpty)) {
            ref.read(mailListProvider.notifier).addMail(
                id: idValue,
                toData: toList,
                subjectData: subjectController.text,
                bodyData: bodyController.text,
                bccData: bccList,
                ccData: ccList);
            snakeBar(
                context: context,
                text: "Mail Sent Successfully",
                color: Colors.green);
            Navigator.pushNamed(context, HomePage.id);
          } else if (toList.isEmpty && ccList.isEmpty && bccList.isEmpty) {
            // If to or cc or bcc is empty
            alertDialogBox(
                context: context,
                contentText: AppLocalizations.of(context)!.empty_body_alert);
          } else if (bodyController.text.isEmpty &&
              subjectController.text.isEmpty) {
            // If body field are empty
            alertConfirmationSentMailDialogBox(
                context: context,
                titleText: "Subject and Body is empty",
                contentText:
                    "Are you want to send mail without subject and body",
                confirmText: "Confirm",
                idValue: idValue,
                toList: toList,
                ccList: ccList,
                bccList: bccList,
                subjectData: subjectController.text,
                bodyData: bodyController.text);
          } else if (bodyController.text.isEmpty) {
            // If body field are empty
            alertConfirmationSentMailDialogBox(
                context: context,
                titleText: "Body is empty",
                contentText: "Are you want to send mail without body",
                confirmText: "Confirm",
                idValue: idValue,
                toList: toList,
                ccList: ccList,
                bccList: bccList,
                subjectData: subjectController.text,
                bodyData: bodyController.text);
          } else if (subjectController.text.isEmpty) {
            // If subject field are empty
            alertConfirmationSentMailDialogBox(
                context: context,
                titleText: "Subject is empty",
                contentText: "Are you want to send mail without Subject",
                confirmText: "Confirm",
                idValue: idValue,
                toList: toList,
                ccList: ccList,
                bccList: bccList,
                subjectData: subjectController.text,
                bodyData: bodyController.text);
          }
        },
        icon: const Icon(Icons.send_outlined));
  }
}

// Used in bin to empty the bin
Future<dynamic> alertConfirmationSentMailDialogBox({
  required BuildContext context,
  required String titleText,
  required String contentText,
  required String confirmText,
  required int idValue,
  required List<UserDetails> toList,
  required List<UserDetails> ccList,
  required List<UserDetails> bccList,
  required String subjectData,
  required String bodyData,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titleText),
        content: Text(contentText),
        actions: <Widget>[
          OutlinedButton(
            style: buttonStyle,
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return OutlinedButton(
              style: buttonStyle,
              child: Text(confirmText),
              onPressed: () {
                ref.read(mailListProvider.notifier).addMail(
                    id: idValue,
                    toData: toList,
                    subjectData: subjectData,
                    bodyData: bodyData,
                    bccData: bccList,
                    ccData: ccList);
                Navigator.pushNamedAndRemoveUntil(
                    context, HomePage.id, (route) => false);
              },
            );
          })
        ],
      );
    },
  );
}
