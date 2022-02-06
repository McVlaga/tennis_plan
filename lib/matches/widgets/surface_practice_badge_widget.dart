import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../models/a_match.dart';

class SurfacePracticeBadgeWidget extends StatelessWidget {
  const SurfacePracticeBadgeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AMatch match = context.watch<AMatch>();
    return Container(
      height: 20,
      width: double.infinity,
      decoration: BoxDecoration(
        color: match.getSurfaceColor(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingTwo),
        child: Row(
          children: [
            if (match.courtSurface != null)
              Text(
                match.buildSurfaceLocationString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 12,
                ),
              ),
            const Spacer(),
            Text(
              match.getDateString(context),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
