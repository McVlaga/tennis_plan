import 'package:flutter/material.dart';

import '../constants/constants.dart';

class ScreenSaveButton extends StatelessWidget {
  const ScreenSaveButton({
    required this.saveFunction,
    Key? key,
  }) : super(key: key);

  final void Function() saveFunction;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(
          left: Dimensions.paddingTwo,
          right: Dimensions.paddingTwo,
          bottom: Dimensions.paddingTwo,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(Dimensions.borderRadius),
          ),
          child: Material(
            color: Colors.red,
            child: InkWell(
              onTap: saveFunction,
              child: SizedBox(
                height: Dimensions.addMatchDialogInputHeight,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
