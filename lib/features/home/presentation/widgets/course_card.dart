import 'package:flutter/material.dart';

import 'package:circular_chart_flutter/circular_chart_flutter.dart';

import '../../../../core/models/courses_model.dart';

class CourseCard extends StatelessWidget {
  final CourseElement course;
  final int completedPercentage;

  const CourseCard({
    super.key,
    required this.course,
    required this.completedPercentage,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final textTheme = Theme.of(context).textTheme;
    final uncompletedPercentage = 100 - completedPercentage;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                const Text('Profesor'),
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedCircularChart(
                  size: const Size(56, 56),
                  percentageValues: true,
                  holeLabel: '$completedPercentage%',
                  initialChartData: <CircularStackEntry>[
                    CircularStackEntry([
                      CircularSegmentEntry(
                        completedPercentage.toDouble(),
                        primaryColor,
                        rankKey: 'Completado',
                      ),
                      CircularSegmentEntry(
                        uncompletedPercentage.toDouble(),
                        primaryColor.withOpacity(0.2),
                        rankKey: 'Restante',
                      ),
                    ])
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
