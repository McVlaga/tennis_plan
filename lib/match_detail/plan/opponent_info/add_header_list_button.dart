import 'package:flutter/material.dart';
import '../../../constants/constants.dart';

class AddHeaderListButton extends StatelessWidget {
  const AddHeaderListButton({
    Key? key,
    required this.title,
    required this.showDialog,
  }) : super(key: key);

  final String title;
  final void Function() showDialog;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
              Icons.add,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ],
        ),
      ),
      onTap: showDialog,
    );
  }
}
