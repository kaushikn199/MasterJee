import 'package:flutter/material.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/widgets/text.dart';

Widget buildRadioOption({
  required String title,
  required int value,
  required int groupValue,
  required ValueChanged<int?> onChanged,
}) {
  return RadioListTile<int>(
    contentPadding: EdgeInsets.zero, // removes outer padding
    visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0), // tightens layout
    title: CommonText(title, size: 14, color: colorBlack),
    value: value,
    groupValue: groupValue,
    selectedTileColor: colorGreen,
    activeColor: colorGreen,
    onChanged: onChanged,
  );
}
