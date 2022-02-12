import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../opponent_info/models/strengths.dart';
import 'strength_item_widget.dart';
import '../../widgets/section_header_widget.dart';

class StrengthsListWidget extends StatelessWidget {
  const StrengthsListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> strengths = context.watch<Strengths>().strengths;
    if (strengths.isEmpty) return const SizedBox.shrink();
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
            title: 'Strengths',
            icon: Icons.shield,
          ),
          const SizedBox(height: 8),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return StrengthItemWidget(
                strength: strengths[index],
              );
            },
            itemCount: strengths.length,
            separatorBuilder: (_, __) {
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
