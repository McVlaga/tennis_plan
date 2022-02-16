import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../opponent_info/models/strengths.dart';
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

class StrengthItemWidget extends StatelessWidget {
  const StrengthItemWidget({
    Key? key,
    required this.strength,
  }) : super(key: key);

  final String strength;

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
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(top: 4),
          ),
          const SizedBox(width: 16),
          Flexible(child: Text(strength)),
        ],
      ),
    );
  }
}
