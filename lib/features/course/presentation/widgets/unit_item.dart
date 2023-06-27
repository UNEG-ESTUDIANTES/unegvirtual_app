import 'package:flutter/material.dart';

import 'package:classroom_app/core/entities/entities.dart';

class UnitItem extends StatelessWidget {
  final Unit unit;

  const UnitItem(this.unit, {super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.blue, width: 2.0),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            color: Colors.blue,
            child: Text(
              'Unidad ${unit.number}',
              style: textTheme.titleMedium?.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(width: 16),
          Text(unit.name),
        ],
      ),
    );
  }
}
