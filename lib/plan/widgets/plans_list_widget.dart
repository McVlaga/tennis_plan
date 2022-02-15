import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/court_drawing_manager.dart';
import '../../constants/constants.dart';
import '../../tactics/models/tactical_plans.dart';
import '../../tactics/models/tactical_plan.dart';

class PlansListWidget extends StatefulWidget {
  const PlansListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PlansListWidget> createState() => _PlansListWidgetState();
}

class _PlansListWidgetState extends State<PlansListWidget> {
  bool firstInit = true;
  late CourtDrawingManager _courtManager;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstInit) {
      final canvasWidth = (MediaQuery.of(context).size.width - 80) / 3;
      _courtManager = CourtDrawingManager(context, canvasWidth);
      firstInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TacticalPlan> plans = context.watch<TacticalPlans>().plans;
    return ListView.separated(
      shrinkWrap: true,
      itemCount: plans.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(
                Radius.circular(Dimensions.borderRadius)),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                const SizedBox(width: 16),
                Center(
                  child: ClipRRect(
                    child: Container(
                      width: _courtManager.canvasWidth,
                      height: _courtManager.canvasHeight,
                      alignment: Alignment.topLeft,
                      color: Colors.transparent,
                      child: plans[index].drawing == null
                          ? _courtManager.buildCourtWidget()
                          : _courtManager
                              .buildCourtDrawingWidget(plans[index].drawing!),
                    ),
                  ),
                ),
                const VerticalDivider(
                    width: 32, thickness: 1, indent: 12, endIndent: 12),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: _courtManager.courtPaddingTop,
                      horizontal: _courtManager.courtPaddingTop / 2,
                    ),
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
