import 'dart:convert';

import 'package:flutter/material.dart';

import '../../data/models/course_model.dart';

class CoursesSlidder extends StatefulWidget {
  @override
  State<CoursesSlidder> createState() => _CoursesSlidderState();
}

class _CoursesSlidderState extends State<CoursesSlidder> {
  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {}
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: 200,
      child: Column(
        children: [
          Text(
            'Carreras',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (_, int index) => CourseCard(
                        Course(name: 'curso', sumary: 'intento'),
                      )),
            ),
          ),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard(this.course);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(blurRadius: 4)]),
      margin: EdgeInsets.all(8),
      width: 120,
      child: Column(
        children: [
          Container(
              height: 80,
              width: 185,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(8))),
          Container(
              alignment: Alignment.center,
              height: 50,
              width: 170,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(course.name, style: TextStyle(fontSize: 20))),
        ],
      ),
    );
  }
}
