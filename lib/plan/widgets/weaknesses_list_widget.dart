import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../opponent_info/models/weaknesses.dart';
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
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius:
            const BorderRadius.all(Radius.circular(Dimensions.borderRadius)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          const SectionHeaderWidget(
              title: 'Weaknesses', icon: Icons.broken_image),
          const SizedBox(height: 8),
          Column(
            children: [
              for (int i = 0; i < weaknesses.length; i++) ...[
                WeaknessItemWidget(weakness: weaknesses[i]),
                if (i < weaknesses.length - 1)
                  const Divider(height: 1, thickness: 1, indent: 42),
              ]
            ],
          ),
          const SizedBox(height: 8),
          // ListView.separated(
          //   shrinkWrap: true,
          //   padding: EdgeInsets.zero,
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemBuilder: (_, index) {
          //     return WeaknessItemWidget(
          //       weakness: weaknesses[index],
          //     );
          //   },
          //   itemCount: weaknesses.length,
          //   separatorBuilder: (_, index) {
          //     return const Divider(
          //       height: 1,
          //       thickness: 1,
          //       indent: 41,
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}

class WeaknessItemWidget extends StatelessWidget {
  const WeaknessItemWidget({
    Key? key,
    required this.weakness,
  }) : super(key: key);
  final String weakness;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingTwo,
        vertical: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10.0,
            height: 10.0,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(top: 4),
          ),
          const SizedBox(width: 16),
          Flexible(child: Text(weakness)),
        ],
      ),
    );
  }
}
