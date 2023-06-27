import 'package:flutter/material.dart';

import 'package:classroom_app/core/entities/career.dart';

class CareerCard extends StatelessWidget {
  /// The [career] to display.
  final Career career;

  /// The [maxHeight] of the list which renders this item.
  final double maxHeight;

  const CareerCard(
    this.career, {
    super.key,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: maxHeight * 0.60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    career.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
