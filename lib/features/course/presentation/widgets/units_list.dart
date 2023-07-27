import 'package:flutter/material.dart';

import 'package:unegvirtual_app/core/entities/entities.dart';
import 'package:unegvirtual_app/features/course/presentation/widgets/unit_item.dart';

class UnitsList extends StatelessWidget {
  final List<Unit> units;

  const UnitsList(this.units, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => UnitItem(units[index]),
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: units.length,
    );
  }
}
