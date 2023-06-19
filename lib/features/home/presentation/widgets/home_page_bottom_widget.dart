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
          const Color.fromARGB(255, 36, 33, 237).withOpacity(0.632)
        ], begin: Alignment.topCenter),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 150,
            width: 150,
            child: Image.asset('assets/uneg_logo.png'),
          ),
          Column(
            children: [
              const SizedBox(height: 70),
              const Text(
                "Informacion",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(
                "Carreras Universitarias",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(
                "Ver Anuncios",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      'assets/facebook_logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(width: 20)
        ],
      ),
    );
  }
}
