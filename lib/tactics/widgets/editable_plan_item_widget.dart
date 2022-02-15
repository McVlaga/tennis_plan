import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_plan/constants/constants.dart';
import 'package:tennis_plan/services/court_drawing_manager.dart';
import 'package:tennis_plan/tactics/models/tactical_plan.dart';

class EditablePlanItemWidget extends StatefulWidget {
  const EditablePlanItemWidget({
    Key? key,
    required this.openEditScreenFunction,
  }) : super(key: key);

  final void Function() openEditScreenFunction;

  @override
  State<EditablePlanItemWidget> createState() => _EditablePlanItemWidgetState();
}

class _EditablePlanItemWidgetState extends State<EditablePlanItemWidget> {
  bool firstInit = true;

  late CourtDrawingManager _courtManager;

  late TacticalPlan plan;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstInit) {
      final canvasWidth = (MediaQuery.of(context).size.width / 2) - 16;
      _courtManager = CourtDrawingManager(context, canvasWidth, 2);
      plan = context.watch<TacticalPlan>();
      bool darkMode = Theme.of(context).brightness == Brightness.dark;
      if (plan.color.value == Colors.black.value && darkMode) {
        plan.setColor(Colors.white);
      } else if (plan.color.value == Colors.white.value && !darkMode) {
        plan.setColor(Colors.black);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimensions.borderRadius),
        ),
        child: Material(
          color: Theme.of(context).colorScheme.surface,
          child: InkWell(
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
                      child: plan.drawing == null
                          ? _courtManager.buildCourtWidget()
                          : _courtManager
                              .buildCourtDrawingWidget(plan.drawing!),
                    ),
                  ),
                  const VerticalDivider(
                      width: 0, thickness: 1, indent: 16, endIndent: 16),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 30.0,
                        bottom: 16,
                        right: 16,
                        left: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plan.title,
                            style: TextStyle(
                              fontSize: 18,
                              color: plan.color,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(plan.description),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: widget.openEditScreenFunction,
          ),
        ),
      ),
    );
  }
}
