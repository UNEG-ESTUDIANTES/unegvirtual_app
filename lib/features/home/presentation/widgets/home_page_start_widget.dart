import 'package:flutter/material.dart';

class HomePageStartWidget extends StatelessWidget {
  const HomePageStartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      alignment: Alignment.centerLeft,
      height: 420,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/landing_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SizedBox(
          width: 375,
          child: Text(
            'Ayudando a formar las mentes del mañana',
            style: textTheme.displaySmall?.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
