import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state_management/mail_list.dart';

class StarredIconButtonWidget extends ConsumerWidget {
  const StarredIconButtonWidget({
    super.key,
    required this.isStarred,
    required this.id,
  });
  final int id;
  final bool isStarred;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        ref.read(mailListProvider.notifier).upadateStar(id);
      },
      icon: isStarred
          ? Icon(Icons.star, color: Colors.yellow.shade700)
          : const Icon(
              Icons.star_border,
            ),
      alignment: Alignment.topRight,
      padding: EdgeInsets.zero,
    );
  }
}
