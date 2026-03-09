import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'home.dart';

class HomeApiUsageScreen extends GetView<HomeApiUsageController> {
  const HomeApiUsageScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("API USAGE", style: TextStyle(color: Colors.white70)),
        centerTitle: true,
        backgroundColor: Colors.black87,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      // 2. Çok sayıda buton olacağı için ListView kullanmak kaydırılabilirlik sağlar
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        itemCount: controller.apiList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(
                  double.infinity,
                  55,
                ), // Butonları tam genişlik ve sabit yükseklik yapar
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => controller.onApiItemSelected(index),
              child: Text(
                controller.apiList[index],
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
