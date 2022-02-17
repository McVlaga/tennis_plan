import 'package:flutter/material.dart';

import 'color_picker_button.dart';

class ColorPickerDialog extends StatelessWidget {
  const ColorPickerDialog({required this.selectedColor, Key? key})
      : super(key: key);

  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Select color",
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ColorPickerButton(
                color: Theme.of(context).colorScheme.onPrimary,
                checked:
                    selectedColor == Theme.of(context).colorScheme.onPrimary,
              ),
              ColorPickerButton(
                color: Colors.blue,
                checked: selectedColor.value == Colors.blue.value,
              ),
              ColorPickerButton(
                color: Colors.green,
                checked: selectedColor.value == Colors.green.value,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ColorPickerButton(
                color: Colors.orange,
                checked: selectedColor.value == Colors.orange.value,
              ),
              ColorPickerButton(
                color: Colors.red,
                checked: selectedColor.value == Colors.red.value,
              ),
              ColorPickerButton(
                color: Colors.purpleAccent,
                checked: selectedColor.value == Colors.purpleAccent.value,
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
