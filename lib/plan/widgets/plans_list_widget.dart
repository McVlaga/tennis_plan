import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_plan/services/court_drawing_manager.dart';
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
      final canvasWidth = (MediaQuery.of(context).size.width / 2) - 16;
      _courtManager = CourtDrawingManager(context, canvasWidth, 2);
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
        return ClipRRect(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(
                  Radius.circular(Dimensions.borderRadius)),
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
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
                  const VerticalDivider(
                      width: 0, thickness: 1, indent: 8, endIndent: 8),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 30.0,
                        bottom: 30,
                        right: 16,
                        left: 24,
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
          ),
        );
      },
      separatorBuilder: (_, __) {
        return const Divider(color: Colors.transparent, height: 16);
      },
    );
  }
}
