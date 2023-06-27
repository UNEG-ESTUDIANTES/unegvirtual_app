import 'package:flutter/material.dart';

class NotesTableWidget extends StatelessWidget {
  const NotesTableWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 20,
      itemBuilder: (context, index) {
        return ListTile(
          title: Row(
            children: [
              SizedBox(width: 34),
              Text("Materia $index",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.start),
              Expanded(child: SizedBox(width: 1)),
              Text("10",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.start),
              SizedBox(width: 22),
            ],
          ),
        );
      },
    );
  }
}
