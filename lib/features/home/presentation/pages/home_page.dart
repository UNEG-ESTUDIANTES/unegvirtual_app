import 'package:flutter/material.dart';

import 'package:classroom_app/features/home/presentation/widgets/courses_slider.dart';

import '../widgets/hero_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const Image(
          image: AssetImage(
            'assets/uneg_logo.png',
          ),
          height: 32,
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.language,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.login,
              color: Colors.white,
            ),
          ),
        ],
        scrolledUnderElevation: 1.0,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HeroSection(),
            SizedBox(height: 20),
            CoursesSlider([]),
            SizedBox(height: 40),
            // Text(
            //   'Mantente Informado',
            //   style: TextStyle(
            //     color: Color.fromARGB(255, 10, 63, 106),
            //     fontSize: 35,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // NewsHomePageWidget(),
          ],
        ),
      ),
    );
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
        padding: const EdgeInsets.all(4),
        width: 250,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: const Color.fromARGB(255, 14, 103, 175),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'Anuncios',
          style: TextStyle(
            color: Color.fromARGB(255, 14, 103, 175),
            fontSize: 30,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
