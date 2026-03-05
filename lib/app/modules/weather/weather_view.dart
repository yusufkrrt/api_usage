import 'package:api_usage/app/modules/weather/weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// weather_screen.dart

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
                // Şehir Girişi
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: controller.textController,
                    decoration: const InputDecoration(
                      hintText: "Şehir girin",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Gün Seçimi (Dropdown)
                Obx(() => DropdownButton<int>(
                  value: controller.day.value,
                  items: controller.dayOptions.map((int val) {
                    return DropdownMenuItem<int>(
                      value: val,
                      child: Text("$val Gün"),
                    );
                  }).toList(),
                  onChanged: (newValue) => controller.onDayChanged(newValue),
                )),

                // Arama Butonu
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.blue),
                  onPressed: () => controller.onSearchCity(),
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
                    Text(state!.location.name,
                        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                    Text("${state.current.tempC}°C",
                        style: const TextStyle(fontSize: 50)),
                    Text(state.current.condition.text),
                    Image.network(
                      "https:${state.current.condition.icon}",
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                    ),
                    const SizedBox(height: 20),
                    Text("Tahmin süresi: ${controller.day.value} Gün"),
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