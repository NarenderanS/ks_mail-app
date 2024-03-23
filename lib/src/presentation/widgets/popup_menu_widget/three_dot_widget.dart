import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/presentation/riverpod/mail_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utils/constants/commom_functions.dart';

class ThreeDotPopUpMenuButtonWidget extends ConsumerWidget {
  const ThreeDotPopUpMenuButtonWidget(
      {super.key, required this.id, required this.page});
  final int id;
  final int page;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (BuildContext context) => [
              if (page == 4)
                PopupMenuItem(
                    enabled: true,
                    onTap: () =>
                        moveFromBin(context: context, ref: ref, mailId: id),
                    child:  Text(AppLocalizations.of(context)!.move_to)),
              PopupMenuItem(
                  enabled: true,
                  onTap: () {
                    ref.read(mailListNotifierProvider.notifier).deleteMail(id);
                    snackBar(
                        context: context, text: AppLocalizations.of(context)!.content_mail_del_per);
                    Navigator.pop(context);
                  },
                  child:  Text(AppLocalizations.of(context)!.delete_per)),
            ]);
  }
}
