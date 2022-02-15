import 'package:flutter/material.dart';

class ColorPickerButton extends StatelessWidget {
  const ColorPickerButton(
      {required this.color, required this.checked, Key? key})
      : super(key: key);

  final Color color;
  final bool checked;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 50,
      icon: CircleAvatar(
        backgroundColor: color,
        child: checked
            ? Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.onSecondary,
              )
            : null,
      ),
      onPressed: () {
        Navigator.pop(context, color);
      },
    );
  }
}
