import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 48.0,
        horizontal: 32.0,
      ),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff023272),
            Color(0xff4E99FD),
          ],
          begin: Alignment.centerLeft,
        ),
      ),
      child: ScreenTypeLayout.builder(
        mobile: (_) => Column(
          children: [
            Image.asset(
              'assets/uneg_logo.png',
              width: 64,
              height: 64,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 32),
            const Links(),
          ],
        ),
        tablet: (_) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/uneg_logo.png',
              width: 80,
              height: 80,
              fit: BoxFit.contain,
            ),
            const Links(),
          ],
        ),
      ),
    );
  }
}

class Links extends StatelessWidget {
  const Links({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: const FaIcon(
            FontAwesomeIcons.facebookF,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const FaIcon(
            FontAwesomeIcons.instagram,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const FaIcon(
            FontAwesomeIcons.twitter,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const FaIcon(
            FontAwesomeIcons.whatsapp,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
