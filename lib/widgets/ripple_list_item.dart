import 'package:flutter/material.dart';

import '../constants/constants.dart';

class RippleListItem extends StatelessWidget {
  const RippleListItem({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.paddingZero,
        bottom: Dimensions.paddingZero,
      ),
      child: ClipRRect(
        borderRadius:
            const BorderRadius.all(Radius.circular(Dimensions.borderRadius)),
        child: Material(
          color: Theme.of(context).colorScheme.surface,
          child: child,
        ),
      ),
    );
  }
}
