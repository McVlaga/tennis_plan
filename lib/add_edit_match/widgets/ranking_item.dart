import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../settings/widgets/settings_item_widget.dart';
import '../models/validation_match.dart';

class RankingItem extends StatelessWidget {
  const RankingItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newMatch = Provider.of<ValidationMatch>(context);
    return SizedBox(
      height: Dimensions.addMatchDialogInputHeight,
      child: InkWell(
        child: SettingsItemWidget(
          title: 'Ranking',
          label: newMatch.opponentRankingString,
          showError: newMatch.showError(newMatch.opponentRanking),
        ),
        onTap: () {
          showDialog(context, newMatch);
        },
      ),
    );
  }

  void showDialog(BuildContext ctx, ValidationMatch newMatch) {
    TextEditingController fedController = TextEditingController();
    TextEditingController posController = TextEditingController();
    if (newMatch.opponentRanking != null) {
      fedController.text = newMatch.opponentRanking!.federation;
      posController.text = '${newMatch.opponentRanking!.position}';
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
                      newMatch.setOpponentRanking(
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
      },
    );
  }
}
