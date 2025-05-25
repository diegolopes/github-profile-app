import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    IconData platformIcon;
    Color iconColor;

    if (kIsWeb) {
      platformIcon = FontAwesomeIcons.chrome;
      iconColor = Colors.blue;
    } else if (Platform.isAndroid) {
      platformIcon = FontAwesomeIcons.android;
      iconColor = Colors.green;
    } else if (Platform.isIOS) {
      platformIcon = FontAwesomeIcons.apple;
      iconColor = Colors.black;
    } else {
      platformIcon = Icons.device_unknown;
      iconColor = Colors.grey;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o App'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              platformIcon,
              size: 64,
              color: iconColor,
            ),
            const SizedBox(height: 24),
            const Text(
              'GitHub Profile App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Versão 1.0.0',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Autor: ',
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () async {
                    const url = 'https://github.com/diegolopes';
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                    }
                  },
                  child: const Text(
                    '@diegolopes',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}