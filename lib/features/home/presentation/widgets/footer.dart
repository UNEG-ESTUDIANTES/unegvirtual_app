import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Desktop layout
          if (constraints.maxWidth > 600) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/uneg_logo.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
                const Links(),
              ],
            );
          }

          // Mobile layout
          return Column(
            children: [
              const Links(crossAlignment: WrapCrossAlignment.center),
              const SizedBox(height: 32),
              Image.asset(
                'assets/uneg_logo.png',
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
            ],
          );
        },
      ),
    );
  }
}

class Links extends StatelessWidget {
  final WrapCrossAlignment? crossAlignment;

  const Links({super.key, this.crossAlignment});

  @override
  Widget build(BuildContext context) {
    const links = ["Información", "Carreras Universitarias", "Anuncios"];

    return Wrap(
      crossAxisAlignment: crossAlignment ?? WrapCrossAlignment.start,
      direction: Axis.vertical,
      spacing: 16,
      children: links.map((link) {
        return Text(
          link,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        );
      }).toList(),
    );
  }
}
