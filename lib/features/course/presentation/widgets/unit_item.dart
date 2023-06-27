import 'package:flutter/material.dart';

import 'package:responsive_builder/responsive_builder.dart';

import 'package:classroom_app/core/entities/entities.dart';

class UnitItem extends StatelessWidget {
  final Unit unit;

  const UnitItem(
    this.unit, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.isDesktop || sizingInformation.isTablet) {
          return _UnitWrapper(
            child: Row(
              children: [
                _UnitTitleWrapper(unit.number),
                const SizedBox(width: 16),
                Text(unit.name),
              ],
            ),
          );
        }

        return _UnitWrapper(
          child: Column(
            children: [
              _UnitTitleWrapper(unit.number),
              const SizedBox(width: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(unit.name),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _UnitWrapper extends StatelessWidget {
  final Widget child;

  const _UnitWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.blue, width: 2.0),
      ),
      child: child,
    );
  }
}

class _UnitTitleWrapper extends StatelessWidget {
  final int number;

  const _UnitTitleWrapper(this.number);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      color: Colors.blue,
      child: Text(
        'Unidad $number',
        style: textTheme.titleMedium?.copyWith(color: Colors.white),
      ),
    );
  }
}
