import 'package:flutter/material.dart';

import '../../../../core/widgets/main_app_bar.dart';

class LogInPage extends StatelessWidget {
  /// The page route name.
  static const routeName = 'login';

  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 228, 227, 227),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 120),
          child: Center(
              child: Container(
            height: 550,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: Column(
              children: [
                SizedBox(height: 20),
                const Image(
                  image: AssetImage(
                    'assets/uneg_logo_color.png',
                  ),
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 10),
                Text("Accede al aula virtual",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text(
                  "Si eres estudiante regular de la UNEG, ingresa al sistema con Cedula de Identidad",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 250,
                  height: 55,
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Correo Electronico o Usuario",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18))),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 250,
                  height: 55,
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Contraseña",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18))),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: (() {}),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(18))),
                      fixedSize: Size(250, 30)),
                  child: Text("Iniciar Seción",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 10),
                Text(
                  "¿Olvido su nombre de usuario o contraseña?",
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: (() {}),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(18))),
                      fixedSize: Size(250, 30)),
                  child: Text("Iniciar Seción como invitado",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
          )),
        ));
  }
}
