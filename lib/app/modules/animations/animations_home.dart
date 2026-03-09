import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AnimationsHome extends StatelessWidget {
  const AnimationsHome({super.key});

  final List<String> _animations = const [
    // Buraya animasyon çalışmaları eklenecek
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ANIMATIONS', style: TextStyle(color: Colors.white70)),
        centerTitle: true,
        backgroundColor: Colors.black87,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white70),
          onPressed: () => Get.back(),
        ),
      ),
      body: _animations.isEmpty
          ? const Center(
              child: Text(
                'Henüz animasyon eklenmedi',
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              itemCount: _animations.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      _animations[index],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

