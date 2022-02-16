import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../settings/widgets/settings_item_widget.dart';
import '../models/validation_match.dart';

class RankingItem extends StatelessWidget {
  const RankingItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final match = context.watch<ValidationMatch>();
    return SizedBox(
      height: Dimensions.addMatchDialogInputHeight,
      child: InkWell(
        child: SettingsItemWidget(
          title: 'Ranking',
          label: match.opponentRankingString,
          showError: match.showError(match.opponentRanking),
        ),
        onTap: () {
          showDialog(context, match);
        },
      ),
    );
  }

  void showDialog(BuildContext ctx, ValidationMatch match) {
    TextEditingController fedController = TextEditingController();
    TextEditingController posController = TextEditingController();
    if (match.opponentRanking != null) {
      fedController.text = match.opponentRanking!.federation;
      posController.text = '${match.opponentRanking!.position}';
    }
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
        return RankingInfoDialog(
          match: match,
          fedController: fedController,
          posController: posController,
        );
      },
    );
  }
}

class RankingInfoDialog extends StatelessWidget {
  const RankingInfoDialog({
    Key? key,
    required this.match,
    required this.fedController,
    required this.posController,
  }) : super(key: key);

  final ValidationMatch match;
  final TextEditingController fedController;
  final TextEditingController posController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: Dimensions.paddingFour,
        right: Dimensions.paddingFour,
        top: Dimensions.paddingFour,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Federation'),
          ),
          TextField(
            autofocus: true,
            controller: fedController,
            textCapitalization: TextCapitalization.characters,
            onChanged: null,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Federation acronym',
            ),
          ),
          const SizedBox(height: Dimensions.paddingThree),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Position',
            ),
          ),
          TextField(
            autofocus: true,
            keyboardType: TextInputType.number,
            controller: posController,
            textCapitalization: TextCapitalization.sentences,
            onChanged: null,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Ranking position',
            ),
          ),
          const SizedBox(height: Dimensions.paddingOne),
          Row(
            children: [
              const Spacer(),
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(width: Dimensions.paddingTwo),
              TextButton(
                child: const Text(
                  'SAVE',
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  match.setOpponentRanking(
                      fedController.text, posController.text);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const SizedBox(height: Dimensions.paddingTwo),
        ],
      ),
    );
  }
}
