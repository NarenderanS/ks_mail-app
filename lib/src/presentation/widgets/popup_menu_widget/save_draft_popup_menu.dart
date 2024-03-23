import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/domain/entities/user_details.dart';
import 'package:ks_mail/src/presentation/riverpod/mail_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utils/constants/commom_functions.dart';

// ignore: must_be_immutable
class ThreeSaveDraftDotPopUpMenuButtonWidget extends StatelessWidget {
  ThreeSaveDraftDotPopUpMenuButtonWidget(
      {super.key,
      required this.subjectController,
      required this.bodyController,
      required this.ref,
      required this.toList,
      required this.bccList,
      required this.ccList,
      required this.id,
      required this.idReturn});

  final TextEditingController subjectController;
  final TextEditingController bodyController;
  final WidgetRef ref;
  final List<UserDetails> toList;
  final List<UserDetails> bccList;
  final List<UserDetails> ccList;
  final void Function(int) idReturn;
  int id;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                  enabled: subjectController.text.isNotEmpty ||
                      bodyController.text.isNotEmpty,
                  onTap: () async {
                    if (id == 0) {
                      id = await ref
                          .read(mailListNotifierProvider.notifier)
                          .addDraft(
                              toData: toList,
                              subjectData: subjectController.text,
                              bodyData: bodyController.text,
                              bccData: bccList,
                              ccData: ccList);
                      idReturn(id);
                    } else {
                      ref.read(mailListNotifierProvider.notifier).editDraft(
                          id: id,
                          toData: toList,
                          subjectData: subjectController.text,
                          bodyData: bodyController.text,
                          bccData: bccList,
                          ccData: ccList);
                      idReturn(id);
                    }

                    if (context.mounted) {
                      snackBar(
                          context: context,
                          text: AppLocalizations.of(context)!.draft_success,
                          color: Colors.green);
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.save_draft)),
            ]);
  }
}
