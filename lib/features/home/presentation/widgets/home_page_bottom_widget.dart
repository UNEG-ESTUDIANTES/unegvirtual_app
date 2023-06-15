import 'package:flutter/material.dart';

class HomePageBottomWidget extends StatelessWidget {
  const HomePageBottomWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blue.withOpacity(0.6),
            Color.fromARGB(255, 36, 33, 237).withOpacity(0.632)
          ], begin: Alignment.topCenter),
        ),
        child: Row(children: [
          Container(
            height: 150,
            width: 150,
            child: Image.asset('assets/uneg_logo.png'),
          ),
          Expanded(child: SizedBox(width: 1)),
          Column(children: [
            SizedBox(height: 70),
            Text("Informacion",
                style: TextStyle(color: Colors.white, fontSize: 20)),
            Text("Carreras Universitarias",
                style: TextStyle(color: Colors.white, fontSize: 20)),
            Text("Ver Anuncios",
                style: TextStyle(color: Colors.white, fontSize: 20)),
            Row(children: [
              Container(
                  width: 40,
                  height: 40,
                  child: Image.asset('assets/facebook_logo.png',
                      fit: BoxFit.cover)),
              Container(
                  width: 40,
                  height: 40,
                  child: Image.asset('assets/facebook_logo.png',
                      fit: BoxFit.cover)),
              Container(
                  width: 40,
                  height: 40,
                  child: Image.asset('assets/facebook_logo.png',
                      fit: BoxFit.cover)),
              Container(
                  width: 40,
                  height: 40,
                  child: Image.asset('assets/facebook_logo.png',
                      fit: BoxFit.cover)),
              Container(
                  width: 40,
                  height: 40,
                  child: Image.asset('assets/facebook_logo.png',
                      fit: BoxFit.cover)),
            ])
          ]),
          SizedBox(width: 20)
        ]));
  }
}
