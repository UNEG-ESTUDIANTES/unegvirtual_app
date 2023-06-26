import 'package:flutter/material.dart';

import 'package:classroom_app/core/entities/career.dart';
import 'package:classroom_app/features/landing/presentation/widgets/career_card.dart';
import 'package:classroom_app/features/landing/presentation/widgets/section.dart';

class CareersSlider extends StatelessWidget {
  /// The [careers] to display.
  final List<Career> careers;

  const CareersSlider(this.careers, {super.key});

  @override
  Widget build(BuildContext context) {
    const height = 250.0;

    return Section(
      title: 'Carreras Universitarias',
      child: careers.isNotEmpty
          ? SizedBox(
              height: height,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => CareerCard(
                  careers[index],
                  maxHeight: height,
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemCount: careers.length,
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.centerLeft,
              child: const Text('No hay carreras disponibles'),
            ),
    );
  }
}
