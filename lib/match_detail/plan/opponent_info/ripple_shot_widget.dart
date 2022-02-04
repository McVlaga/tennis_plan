import 'package:flutter/material.dart';
import 'package:tennis_plan/match_detail/plan/models/opponent_info.dart';
import '../../../constants/constants.dart';
import 'add_edit_shot_dialog.dart';
import '../models/shot.dart';
import '../../../matches/models/a_match.dart';
import '../../../services/theme_manager.dart';

class RippleShotWidget extends StatelessWidget {
  const RippleShotWidget({
    required this.name,
    required this.starNumber,
    required this.opponentInfo,
    required this.editable,
    Key? key,
  }) : super(key: key);

  final String name;
  final String starNumber;
  final OpponentInfo opponentInfo;
  final bool editable;

  void showEditShotDialog(
      BuildContext ctx, OpponentInfo opponentInfo, Shot? shot) {
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
      builder: (context) {
        return AddEditShotDialog(
            context: ctx, opponentInfo: opponentInfo, shot: shot);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Shot shot = opponentInfo.findShotByName(name);
    return ClipRRect(
      borderRadius:
          const BorderRadius.all(Radius.circular(Dimensions.borderRadius)),
      child: Material(
        color: shot.score == 5
            ? Theme.of(context).colorScheme.cardShotGoodBg
            : shot.score == 3 || shot.score == 4
                ? Theme.of(context).colorScheme.cardShotMediumBg
                : Theme.of(context).colorScheme.cardShotBadBg,
        child: InkWell(
          onTap: () {
            if (editable) showEditShotDialog(context, opponentInfo, shot);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      starNumber,
                      style: TextStyle(fontSize: 20),
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
