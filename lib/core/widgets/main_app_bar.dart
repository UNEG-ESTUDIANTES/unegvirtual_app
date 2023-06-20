import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.8,
      leadingWidth: 100,
      leading: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          const Image(
            image: AssetImage(
              'assets/uneg_logo.png',
            ),
            fit: BoxFit.contain,
          ),
        ],
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
      shadowColor: Colors.black,
      backgroundColor: Colors.transparent,
    );
  }
}
