import 'package:flutter/material.dart';

import '../../../../core/widgets/main_app_bar.dart';
import '../widgets/basic_info_widget.dart';
import '../widgets/user_data_widget.dart';

class UserPage extends StatelessWidget {
  /// The page route name.
  static const routeName = 'user';

  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(55), child: MainAppBar()),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          BasicInfoWidget(),
          UserDataWidget(),
          SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: (() {}),
            style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                fixedSize: Size(170, 60)),
            child: Text("Semestre 1",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 50),
              Text("Pensum",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start),
              Expanded(child: SizedBox(width: 1)),
              Text("U.C",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start),
              SizedBox(width: 20),
              Text("U.C",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start),
              SizedBox(width: 20),
            ],
          ),
          ListView.builder(
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
                    SizedBox(width: 25),
                    Text("10",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.start),
                    SizedBox(width: 15),
                  ],
                ),
              );
            },
          )
        ],
      )),
    );
  }
}
