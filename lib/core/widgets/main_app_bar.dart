import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 120,
        leading: Row(
          children: [
            FloatingActionButton(
                onPressed: (() {
                  Scaffold.of(context).openDrawer();
                }),
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: Icon(Icons.menu)),
            Expanded(
                child: Image.asset('assets/uneg_logo.png', fit: BoxFit.cover)),
          ],
        ),
        actions: [
          TextButton(
              onPressed: (() {}),
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(2),
                  width: 60,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: Color.fromARGB(255, 14, 103, 175)),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text('Es',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      textAlign: TextAlign.center))),
          TextButton(
              onPressed: (() {}),
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(2),
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          width: 1, color: Color.fromARGB(255, 14, 103, 175)),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text('Iniciar Secion',
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                      textAlign: TextAlign.center)))
        ]);
  }
}
