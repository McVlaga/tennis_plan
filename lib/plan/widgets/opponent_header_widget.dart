import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../matches/models/a_match.dart';
import '../../opponent_info/models/shot.dart';
import '../../opponent_info/models/shots.dart';
import '../../widgets/flag_name_widget.dart';

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
                const Expanded(child: FlagNameWidget(fullName: true)),
                const SizedBox(width: 16),
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

class ShotsListWidget extends StatelessWidget {
  const ShotsListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Shot> shots = context.watch<Shots>().shots;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingTwo,
      ),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: [
          ...shots.map((shot) {
            return ChangeNotifierProvider.value(
              value: shot,
              builder: (_, __) {
                return const ShotItemWidget();
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}

class ShotItemWidget extends StatelessWidget {
  const ShotItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Shot shot = context.watch<Shot>();
    return DecoratedBox(
      decoration: BoxDecoration(
        color: shot.getShotColor(context),
        borderRadius:
            const BorderRadius.all(Radius.circular(Dimensions.borderRadius)),
      ),
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
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                const Icon(
                  Icons.star,
                  color: Color(0xFFFBC02D),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
