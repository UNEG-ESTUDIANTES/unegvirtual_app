import 'package:flutter/material.dart';

import 'package:classroom_app/features/user/presentation/widgets/user_data_item.dart';

class UserData extends StatelessWidget {
  const UserData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        UserDataItem(
          title: 'Dirección de Correo',
          value: 'ExampleEMail@gmail.com',
        ),
        SizedBox(height: 16),
        UserDataItem(
          title: 'País - Ciudad',
          value: 'Venezuela, Puerto Ordaz',
        ),
        SizedBox(height: 16),
        UserDataItem(
          title: 'Cédula de Identidad',
          value: 'V-10.000.000',
        ),
      ],
    );
  }
}
