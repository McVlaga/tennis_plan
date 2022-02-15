import 'package:flutter/material.dart';
import 'package:tennis_plan/constants/constants.dart';

class CancelSaveBarWidget extends StatelessWidget {
  const CancelSaveBarWidget({required this.saveFunction, Key? key})
      : super(key: key);

  final void Function() saveFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.paddingTwo,
        right: Dimensions.paddingTwo,
        bottom: Dimensions.paddingTwo,
      ),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(Dimensions.borderRadius),
              ),
              child: Material(
                color: Colors.blue,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SizedBox(
                    height: Dimensions.addMatchDialogInputHeight,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'CANCEL',
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
          const SizedBox(width: 16),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(Dimensions.borderRadius),
              ),
              child: Material(
                color: Colors.green,
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
        ],
      ),
    );
  }
}
