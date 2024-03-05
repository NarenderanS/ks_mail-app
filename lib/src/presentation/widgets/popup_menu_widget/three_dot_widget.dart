import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../riverpod/mail_list.dart';
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
                    child: Text("Move to")),
              PopupMenuItem(
                  enabled: true,
                  onTap: () {
                    ref.read(mailListProvider.notifier).deleteMail(id);
                    snakeBar(
                        context: context, text: "Mail deleted permanently");
                    Navigator.pop(context);
                  },
                  child: Text("Delete Permanently")),
            ]);
  }
}
