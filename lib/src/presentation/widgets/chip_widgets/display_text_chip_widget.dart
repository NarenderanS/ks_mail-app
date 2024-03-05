import 'package:flutter/material.dart';

class DisplayTextInChipWidget extends StatelessWidget {
  const DisplayTextInChipWidget(
      {super.key,
      required this.valueList,
      required this.onDelete,
      required this.onPress});

  final List<String> valueList;
  final Function(String) onDelete;
  final void Function(String) onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Wrap(
        children: valueList
            .map(
              (value) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: RawChip(
                  padding: const EdgeInsets.all(1),
                  label: Text(value),
                  onDeleted: () => onDelete(value),
                  onPressed: () => onPress(value),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
