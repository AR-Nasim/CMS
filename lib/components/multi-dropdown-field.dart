import 'dart:core';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class MultiDropdownField extends StatelessWidget {
  const MultiDropdownField(this.title,this.dropdownValue, this.items,this.onChangedCallback);
  final title;
  final String dropdownValue;
  final List<String> items;
  final Function(List<dynamic>)onChangedCallback;

  @override
  Widget build(BuildContext context) {
    return MultiSelectDialogField(
      items: items
          .map((e) => MultiSelectItem(e, e))
          .toList(),
      listType: MultiSelectListType.LIST,
      checkColor: Colors.white,
      selectedColor: Color(0xFF13192F),
      title: Text(title),
      onConfirm: onChangedCallback,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        border: Border.all(
          color: Color(0xFF13192F),
          width: 2,
        ),
      ),
      buttonText: Text(
        dropdownValue,
        style: TextStyle(
          color: Color(0xFF13192F),
          fontSize: 16,
        ),
      ),
      buttonIcon: Icon(Icons.keyboard_arrow_down),
      chipDisplay: MultiSelectChipDisplay.none(),
    );
  }
}
