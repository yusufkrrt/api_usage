import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class PlaygroundHome extends StatelessWidget {
  const PlaygroundHome({super.key});

  final List<Map<String, dynamic>> _sections = const [
    {
      'title': 'API Usage',
      'subtitle': 'News, Music, Weather, Crypto, Movie, Food',
      'route': AppRoutes.home,
    },
    {
      'title': 'Animations',
      'subtitle': 'Flutter animasyon çalışmaları',
      'route': AppRoutes.animations,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FLUTTER PLAYGROUND',
          style: TextStyle(color: Colors.white70),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        itemCount: _sections.length,
        itemBuilder: (context, index) {
          final section = _sections[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 65),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => Get.toNamed(section['route']),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    section['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    section['subtitle'],
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
