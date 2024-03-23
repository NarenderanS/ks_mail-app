import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/domain/entities/user_details.dart';
import 'package:ks_mail/src/presentation/riverpod/mail_provider.dart';

import '../../../utils/constants/commom_functions.dart';
import '../../../utils/constants/styles.dart';
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
          if ((toList.isNotEmpty || ccList.isNotEmpty || bccList.isNotEmpty) &&
              (bodyController.text.isNotEmpty &&
                  subjectController.text.isNotEmpty)) {
            ref.read(mailListNotifierProvider.notifier).addMail(
                id: idValue,
                toData: toList,
                subjectData: subjectController.text,
                bodyData: bodyController.text,
                bccData: bccList,
                ccData: ccList);
            snackBar(
                context: context,
                text: AppLocalizations.of(context)!.mail_sent_s,
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
                titleText: AppLocalizations.of(context)!.body_and_subject_empty,
                contentText:AppLocalizations.of(context)!.content_body_and_subject_empty,
                confirmText: AppLocalizations.of(context)!.confirm,
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
                titleText: AppLocalizations.of(context)!.body_empty,
                contentText: AppLocalizations.of(context)!.content_body_empty,
                confirmText: AppLocalizations.of(context)!.confirm,
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
                titleText: AppLocalizations.of(context)!.subject_empty,
                contentText: AppLocalizations.of(context)!.content_subject_empty,
                confirmText: AppLocalizations.of(context)!.confirm,
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
            child:  Text(AppLocalizations.of(context)!.cancel),
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
                ref.read(mailListNotifierProvider.notifier).addMail(
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
