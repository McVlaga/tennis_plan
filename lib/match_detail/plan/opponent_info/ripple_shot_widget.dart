import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/shots.dart';
import '../../../constants/constants.dart';
import 'add_edit_shot_dialog.dart';
import '../models/shot.dart';

class RippleShotWidget extends StatelessWidget {
  const RippleShotWidget({
    required this.shots,
    Key? key,
  }) : super(key: key);

  final Shots? shots;

  void showAddEditShotDialog(BuildContext ctx, Shot shot) {
    FocusScope.of(ctx).unfocus();
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.borderRadius),
          topRight: Radius.circular(Dimensions.borderRadius),
        ),
      ),
      backgroundColor: Theme.of(ctx).canvasColor,
      builder: (_) {
        return AddEditShotDialog(shots: shots!, shot: shot);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Shot shot = context.watch<Shot>();
    return ClipRRect(
      borderRadius:
          const BorderRadius.all(Radius.circular(Dimensions.borderRadius)),
      child: Material(
        color: shot.getShotColor(context),
        child: InkWell(
          onTap: () {
            if (shots != null) showAddEditShotDialog(context, shot);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  shot.name,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      shot.score.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                    Icon(
                      Icons.star,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
