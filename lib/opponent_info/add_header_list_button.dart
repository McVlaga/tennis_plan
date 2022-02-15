import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class AddHeaderListButton extends StatelessWidget {
  const AddHeaderListButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.function,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final void Function() function;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingTwo),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Icon(
                icon,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ],
          ),
        ),
        onTap: function,
      ),
    );
  }
}
