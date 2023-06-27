import 'package:flutter/material.dart';

class UserDataWidget extends StatelessWidget {
  const UserDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 20),
        Text('Direccion Correo',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text('ExampleEMail@gmail.com', style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        Text('Cedula de Identidad',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text('V-10.000.000', style: TextStyle(fontSize: 18)),
      ],
    );
  }
}
