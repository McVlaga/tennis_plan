import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../matches/models/a_match.dart';
import '../../matches/widgets/flag_and_name_widget.dart';
import '../../opponent_info/models/shots.dart';
import 'shots_list_widget.dart';

class OpponentHeaderWidget extends StatelessWidget {
  const OpponentHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AMatch match = context.watch<AMatch>();
    Shots shots = context.watch<Shots>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingTwo),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius:
            const BorderRadius.all(Radius.circular(Dimensions.borderRadius)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Expanded(child: FlagAndNameWidget(fullName: true)),
                Text(
                  match.isOpponentLefty! ? 'Lefty' : 'Righty',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          if (shots.shots.isNotEmpty) const SizedBox(height: 16),
          if (shots.shots.isNotEmpty) const ShotsListWidget(),
        ],
      ),
    );
  }
}
