import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/constants.dart';
import '../models/a_match.dart';

class SurfacePracticeBadgeWidget extends StatelessWidget {
  const SurfacePracticeBadgeWidget({
    Key? key,
    required this.match,
  }) : super(key: key);

  final AMatch match;

  String buildSurfaceLocationString() {
    if (match.courtSurface != null) {
      String surface = match.courtSurface!.name.toUpperCase();
      if (match.courtSurface == CourtSurface.hard &&
          match.courtLocation != null) {
        String location = match.courtLocation!.name.toUpperCase();
        return '$surface, $location';
      } else {
        return surface;
      }
    }
    return '';
  }

  Color getSurfaceColor() {
    switch (match.courtSurface) {
      case CourtSurface.hard:
        return Colors.blue;
      case CourtSurface.clay:
        return Colors.orange;
      case CourtSurface.grass:
        return Colors.green;
      case CourtSurface.carpet:
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }

  String getDateString(BuildContext context) {
    String time = '';
    String date = '';
    if (match.matchTime != null) {
      time = match.matchTime!.format(context);
    }
    if (match.matchDate != null) {
      date = DateFormat('MMM d, yyyy').format(match.matchDate!);
    }
    return '$time $date';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: double.infinity,
      decoration: BoxDecoration(
        color: getSurfaceColor(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingTwo),
        child: Row(
          children: [
            if (match.courtSurface != null)
              Text(
                buildSurfaceLocationString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 12,
                ),
              ),
            const Spacer(),
            Text(
              getDateString(context),
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
