import 'dart:core';
import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  const DropdownField(this.dropdownValue, this.items,this.onChangedCallback);
  final String dropdownValue;
  final List<String> items;
  final Function onChangedCallback;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border:
        Border.all(color: const Color(0xFF13192F), width: 2.0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: 15.0),
        child: DropdownButton(
          value: dropdownValue,
          items: items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(
                items,
                style: TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            onChangedCallback(newValue);
          },
          underline: Container(),
          isExpanded: true,
        ),
      ),
    );
  }
}
