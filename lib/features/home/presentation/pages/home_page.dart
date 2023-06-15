import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../core/widgets/main_app_bar.dart';
import '../../../../core/widgets/nav_bar.dart';
import '../../data/models/course_model.dart';
import '../widgets/courses_slidder.dart';
import '../widgets/home_page_bottom_widget.dart';
import '../widgets/home_page_start_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 176, 191, 207),
        drawer: NavBarMenu(),
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60), child: MainAppBar()),
        body: SingleChildScrollView(
            child: Column(children: [
          HomePageStartWidget(),
          SizedBox(height: 20),
          CoursesSlidder(),
          SizedBox(height: 40),
          Text('Mantente Informado',
              style: TextStyle(
                  color: Color.fromARGB(255, 10, 63, 106),
                  fontSize: 35,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 40),
          NewsHomePageWidget(),
          HomePageBottomWidget(),
        ])));
  }
}

class NewsHomePageWidget extends StatelessWidget {
  const NewsHomePageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (() {}),
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(4),
            width: 250,
            height: 60,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: Color.fromARGB(255, 14, 103, 175)),
                borderRadius: BorderRadius.circular(20)),
            child: Text('Anuncios',
                style: TextStyle(
                    color: Color.fromARGB(255, 14, 103, 175), fontSize: 30),
                textAlign: TextAlign.center)));
  }
}
