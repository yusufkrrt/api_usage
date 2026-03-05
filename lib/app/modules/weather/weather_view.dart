import 'package:api_usage/app/modules/weather/weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherScreen extends GetView<WeatherController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hava Durumu")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.textController,
                    decoration: const InputDecoration(
                      hintText: "Şehir girin (Örn: Ankara)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => controller.onSearchCity(), // Aramayı başlat
                ),
              ],
            ),
          ),

          // Hava Durumu Sonucu Bölümü
          Expanded(
            child: controller.obx(
                  (state) => SingleChildScrollView(
                child: Column(
                  children: [
                    Text(state!.location.name, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                    Text("${state.current.tempC}°C", style: const TextStyle(fontSize: 50)),
                    Text(state.current.condition.text),
                    Image.network("https:${state.current.condition.icon}"),
                  ],
                ),
              ),
              onLoading: const Center(child: CircularProgressIndicator()),
              onError: (error) => Center(child: Text(error ?? "Hata")),
            ),
          ),
        ],
      ),
    );
  }
}