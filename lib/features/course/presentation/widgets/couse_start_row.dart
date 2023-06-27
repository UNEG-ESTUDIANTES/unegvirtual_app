import 'package:flutter/material.dart';

class StartRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 15),
        Expanded(
          child: Material(
            elevation: 10.0,
            borderRadius: BorderRadius.circular(20.0),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Buscar...',
                  contentPadding: EdgeInsets.all(8.0),
                  suffixIcon: Icon(Icons.search)),
            ),
          ),
        ),
        SizedBox(width: 15),
        FloatingActionButton(
          onPressed: () {},
          shape: CircleBorder(),
          backgroundColor: Colors.white,
          child: Icon(Icons.notifications, color: Colors.yellow),
        ),
        SizedBox(width: 16.0),
        Material(
          elevation: 10.0,
          borderRadius: BorderRadius.circular(20.0),
          child: TextButton(
            onPressed: (() {}),
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              fixedSize: Size(140, 45),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/profile_xample.png'),
                  radius: 15,
                ),
                SizedBox(width: 5),
                Text("Usuario apellido",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        SizedBox(width: 16.0),
      ],
    );
  }
}
