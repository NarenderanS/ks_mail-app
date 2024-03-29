import 'package:flutter/material.dart';

import '../../../utils/constants/constant.dart';
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
          : (diff == 1 ? "Yesterday" : converter.getDisplayDate(createdAt)),
      style: timeStyle,
    );
  }
}
