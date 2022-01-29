import 'package:flutter/material.dart';

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
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: double.infinity,
      decoration: BoxDecoration(color: getSurfaceColor()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingOne),
        child: Row(
          children: [
            Text(
              buildSurfaceLocationString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            const Spacer(),
            Text(
              match.isPractice! ? 'PRACTICE' : '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
