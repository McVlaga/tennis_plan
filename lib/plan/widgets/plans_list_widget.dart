import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../tactics/models/tactical_plans.dart';
import '../../tactics/models/tactical_plan.dart';

class PlansListWidget extends StatelessWidget {
  const PlansListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TacticalPlan> plans = context.watch<TacticalPlans>().plans;
    return ListView.separated(
      shrinkWrap: true,
      itemCount: plans.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: Dimensions.paddingOne,
            horizontal: Dimensions.paddingTwo,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(
              Radius.circular(Dimensions.borderRadius),
            ),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Image.memory(
                    Uint8List.view(
                      plans[index].imageBytes!.buffer,
                    ),
                  ),
                ),
                const VerticalDivider(
                    width: 32, thickness: 1, indent: 8, endIndent: 8),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plans[index].title,
                          style: TextStyle(
                            fontSize: 18,
                            color: plans[index].color,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          plans[index].description,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (_, __) {
        return const Divider(color: Colors.transparent, height: 16);
      },
    );
  }
}
