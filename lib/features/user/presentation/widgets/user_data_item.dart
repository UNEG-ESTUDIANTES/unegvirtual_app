import 'package:flutter/material.dart';

class UserDataItem extends StatelessWidget {
  /// The [title] of the item.
  final String title;

  /// The [value] to display.
  final String value;

  const UserDataItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(value),
      ],
    );
  }
}
