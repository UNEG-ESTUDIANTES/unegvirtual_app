import 'package:flutter/material.dart';

class BasicInfoWidget extends StatelessWidget {
  const BasicInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const SizedBox(
        width: 30,
      ),
      Column(
        children: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/profile_xample.png'),
            radius: 55,
          ),
          SizedBox(height: 2),
          Text('Cambiar foto de perfil',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue))
        ],
      ),
      const SizedBox(
        width: 20,
      ),
      Column(
        children: [
          const Text('Xiao Yaksha',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Row(
            children: const [
              Text('18 ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('/ 20', style: TextStyle(fontSize: 20)),
              Icon(Icons.star, color: Colors.yellow),
              Icon(Icons.star, color: Colors.yellow),
              Icon(Icons.star, color: Colors.yellow),
              Icon(Icons.star, color: Colors.yellow),
              Icon(Icons.star, color: Color.fromARGB(255, 82, 80, 80)),
            ],
          ),
          const Text('2021 I - Actualidad', style: TextStyle(fontSize: 20))
        ],
      ),
      const SizedBox(
        width: 20,
      ),
    ]);
  }
}
