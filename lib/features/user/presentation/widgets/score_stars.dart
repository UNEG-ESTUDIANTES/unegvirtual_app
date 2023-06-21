import 'package:flutter/material.dart';

class ScoreStars extends StatelessWidget {
  final int score;
  final MainAxisAlignment? mainAxisAlignment;
  final maxScore = 20;
  final stars = 5;

  const ScoreStars({super.key, required this.score, this.mainAxisAlignment});

  @override
  Widget build(BuildContext context) {
    final scoreToFillStar = maxScore / stars;

    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        Text(
          '$score',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        Text('/$maxScore'),
        const SizedBox(width: 8),
        Wrap(
          children: List.generate(stars, (index) {
            // Get the score left to fill the star.
            final scoreLeft = score - (scoreToFillStar * (index + 1));

            // In case it's zero or bigger then it can fill the star.
            final starColor =
                scoreLeft >= 0 ? Colors.yellow : Colors.black.withOpacity(0.2);

            return Icon(
              Icons.star,
              color: starColor,
            );
          }),
        ),
      ],
    );
  }
}
