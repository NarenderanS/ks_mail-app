import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/domain/entities/mail.dart';
import 'package:ks_mail/src/domain/entities/user.dart';
import 'package:ks_mail/src/utils/constants/commom_functions.dart';
import 'package:ks_mail/src/presentation/state_management/navigator.dart';

import '../../state_management/user.dart';
import '../../../utils/constants/constant.dart';

class AddressWidget extends ConsumerWidget {
  const AddressWidget({super.key, required this.mail});
  final Mail mail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool ifUserAlreadyReaded = mail.readedBy.contains(currentUser!.id);
    switch (ref.watch(navigatorProvider)) {
      case 0: //inbox
      case 1: //starred
      case 4: //bin
        return Text(
          currentUser!.mail == mail.from.mail ? "me" : mail.from.username,
          style: ifUserAlreadyReaded ? titleReadedFont : titleUnreadedFont,
        );
      case 2: //sent
        return Flexible(
          child: Text(
            getData(
                page: 2,
                toList: mail.to,
                ccList: mail.cc,
                bccList: mail.bcc,
                from: mail.from.mail),
            overflow: TextOverflow.ellipsis,
          ),
        );
      case 3: //draft
        return Text(
          "Draft",
          style: titleReadedFont.copyWith(color: Colors.red),
        );
    }
    return const Text("");
  }
}
