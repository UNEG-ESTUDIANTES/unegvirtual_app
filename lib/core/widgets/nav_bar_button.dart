import 'package:flutter/material.dart';

class NavBarButton extends StatelessWidget {
  final String name;
  final IconData icon;
  const NavBarButton({
    super.key,
    required this.name,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (() {}),
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(2),
            width: 200,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    width: 1, color: Color.fromARGB(255, 59, 165, 192)),
                borderRadius: BorderRadius.circular(20)),
            child: Row(children: [
              SizedBox(
                width: 10,
              ),
              Container(
                  width: 40,
                  height: 40,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 59, 165, 192),
                  ),
                  child: Icon(icon, color: Colors.white)),
              SizedBox(
                width: 10,
              ),
              Text(name,
                  style: TextStyle(
                      color: Color.fromARGB(255, 59, 165, 192), fontSize: 20),
                  textAlign: TextAlign.center),
            ])));
  }
}
