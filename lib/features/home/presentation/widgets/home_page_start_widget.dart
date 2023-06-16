import 'package:flutter/material.dart';

class HomePageStartWidget extends StatelessWidget {
  const HomePageStartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.blue.withOpacity(0.6),
                Colors.white.withOpacity(0.2)
              ], begin: Alignment.topCenter),
            ),
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/uneg_background.jpg'),
                  fit: BoxFit.cover)),
          height: 400),
      Column(children: [
        SizedBox(height: 90),
        Row(
          children: [
            SizedBox(width: 30),
            Container(
              width: 200,
              alignment: AlignmentDirectional.topStart,
              child: Text('Ayudando a formar las mentes del mañana',
                  style: TextStyle(color: Colors.white, fontSize: 25)),
            ),
          ],
        )
      ])
    ]);
  }
}
