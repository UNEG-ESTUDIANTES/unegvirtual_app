import 'package:flutter/material.dart';

import 'package:classroom_app/core/entities/user.dart';
import 'package:classroom_app/features/user/presentation/widgets/user_data_item.dart';

class UserData extends StatelessWidget {
  final User user;

  const UserData({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserDataItem(
          title: 'Cédula de Identidad',
          value: user.identityCard,
        ),
      ],
    );
  }
}
