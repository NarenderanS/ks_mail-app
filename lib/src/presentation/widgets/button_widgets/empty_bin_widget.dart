import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/presentation/riverpod/mail_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utils/constants/styles.dart';
import '../../../utils/constants/variables.dart';

class EmptyBinButtnWidget extends StatelessWidget {
  const EmptyBinButtnWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 13, bottom: 10, left: 7),
        child: Wrap(
          children: [
            OutlinedButton(
                style: buttonStyle.copyWith(),
                onPressed: () => alertConfirmationEmptyBinDialogBox(
                      context: context,
                      titleText: '${AppLocalizations.of(context)!.empty_bin}?',
                      contentText:
                          AppLocalizations.of(context)!.content_del_permanent,
                      confirmText: AppLocalizations.of(context)!.empty_bin,
                    ),
                child: Text(AppLocalizations.of(context)!.empty_bin))
          ],
        ),
      ),
    );
  }
}

// Used in bin to empty the bin
Future<dynamic> alertConfirmationEmptyBinDialogBox(
    {required BuildContext context,
    required String titleText,
    required String contentText,
    required String confirmText}) {
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
            child: Text(AppLocalizations.of(context)!.cancel),
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
                ref
                    .read(mailListNotifierProvider.notifier)
                    .emptyBin(currentUser!.id!);
                Navigator.of(context).pop();
              },
            );
          })
        ],
      );
    },
  );
}
