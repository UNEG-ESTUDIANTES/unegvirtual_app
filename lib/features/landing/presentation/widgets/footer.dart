import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:unegvirtual_app/core/services/notifications_service.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 48.0,
        horizontal: 24.0,
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
    const horizontalSpacing = 16.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => _navigateTo(
            Uri.parse('https://www.facebook.com/UNEGInforma'),
          ),
          icon: const FaIcon(
            FontAwesomeIcons.facebookF,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: horizontalSpacing),
        IconButton(
          onPressed: () => _navigateTo(
            Uri.parse('https://www.instagram.com/Uneg_Oficial/'),
          ),
          icon: const FaIcon(
            FontAwesomeIcons.instagram,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: horizontalSpacing),
        IconButton(
          onPressed: () => _navigateTo(
            Uri.parse('https://twitter.com/UnegInforma'),
          ),
          icon: const FaIcon(
            FontAwesomeIcons.twitter,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: horizontalSpacing),
        IconButton(
          onPressed: () => _navigateTo(
            Uri.parse('https://t.me/Uneginforma'),
          ),
          icon: const FaIcon(
            FontAwesomeIcons.telegram,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  /// Navigates to the [url].
  Future<void> _navigateTo(Uri url) async {
    if (!await launchUrl(url)) {
      NotificationsService.showSnackBar('No se ha podido abrir el enlace');
    }
  }
}
