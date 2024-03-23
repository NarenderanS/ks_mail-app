import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utils/constants/styles.dart';
import '../../../utils/date_time.dart';

class DateTimeDisplayWidget extends StatelessWidget {
  const DateTimeDisplayWidget({
    super.key,
    required this.createdAt,
  });

  final String createdAt;

  @override
  Widget build(BuildContext context) {
    DateTimeFormat converter = DateTimeFormat();
    int diff = DateTimeFormat().getDaysDifference(converter.getDate(createdAt));
    return Text(
      diff == 0
          ? converter.getTime(createdAt)
          : (diff == 1
              ? AppLocalizations.of(context)!.yesterday
              : converter.getDisplayDate(createdAt)),
      style: timeStyle,
    );
  }
}
