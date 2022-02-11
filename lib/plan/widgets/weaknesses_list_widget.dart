import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_plan/constants/constants.dart';
import 'package:tennis_plan/opponent_info/models/weaknesses.dart';
import 'weakness_item_widget.dart';
import '../../widgets/section_header_widget.dart';

class WeaknessesListWidget extends StatelessWidget {
  const WeaknessesListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> weaknesses = context.watch<Weaknesses>().weaknesses;
    if (weaknesses.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingOne),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius:
            const BorderRadius.all(Radius.circular(Dimensions.borderRadius)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          const SectionHeaderWidget(
              title: 'Weaknesses', icon: Icons.broken_image),
          const SizedBox(height: 8),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return WeaknessItemWidget(
                weakness: weaknesses[index],
              );
            },
            itemCount: weaknesses.length,
            separatorBuilder: (_, index) {
              return const Divider(
                height: 1,
                thickness: 1,
                indent: 41,
              );
            },
          ),
        ],
      ),
    );
  }
}
