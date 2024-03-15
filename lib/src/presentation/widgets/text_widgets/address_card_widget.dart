import 'package:flutter/material.dart';
import 'package:ks_mail/src/utils/date_time.dart';

import '../../../utils/constants/styles.dart';

class AddressCardWidget extends StatelessWidget {
  const AddressCardWidget(
      {super.key,
      required this.fromAddress,
      required this.toAddress,
      required this.ccAddress,
      required this.bccAddress,
      required this.dateAndTime});

  final String fromAddress;
  final String toAddress;
  final String ccAddress;
  final String bccAddress;
  final String dateAndTime;

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {0: FixedColumnWidth(50)},
      children: [
        TableRow(
          children: [const Text("From"), Text(fromAddress)],
        ),
        rowSpacer,
        TableRow(
          children: [const Text("To"), Text(toAddress)],
        ),
        rowSpacer,
        if (ccAddress.isNotEmpty)
          TableRow(children: [const Text("Cc"), Text(ccAddress)]),
        if (ccAddress.isNotEmpty) rowSpacer,
        if (bccAddress.isNotEmpty)
          TableRow(children: [const Text("Bcc"), Text(bccAddress)]),
        if (bccAddress.isNotEmpty) rowSpacer,
        TableRow(children: [
          const Text("Date"),
          Text(DateTimeFormat().getDisplayDateAndTime(dateAndTime))
        ]),
      ],
    );
  }
}
