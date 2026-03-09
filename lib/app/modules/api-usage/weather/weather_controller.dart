import 'package:flutter/material.dart'; // TextEditingController için gerekli
import 'package:get/get.dart';import '../../../data/models/weather_model.dart';
import '../../../data/repositories/weather_repository.dart';

class WeatherController extends GetxController with StateMixin<WeatherModel> {
  final WeatherRepository weatherRepository;
  WeatherController({required this.weatherRepository});

  final city = 'Istanbul'.obs;
  final day = 1.obs; // Seçilen gün sayısını tutar
  final textController = TextEditingController();

  // Dropdown için seçenekler listesi
  final List<int> dayOptions = [1, 3, 5, 7, 15];

  @override
  void onInit() {
    super.onInit();
    getWeatherByCity(city.value, day.value);
  }

  // Gün sayısı değiştiğinde çalışacak fonksiyon
  void onDayChanged(int? newValue) {
    if (newValue != null) {
      day.value = newValue;
      // Gün değiştiğinde otomatik olarak mevcut şehirle tekrar ara
      getWeatherByCity(city.value, day.value);
    }
  }

  void onSearchCity() {
    if (textController.text.isNotEmpty) {
      city.value = textController.text;
    }
    // text boş olsa bile mevcut city.value ve güncel day.value ile ara
    getWeatherByCity(city.value, day.value);
  }

  void getWeatherByCity(String cityName, int dayCount) async {
    change(null, status: RxStatus.loading());
    try {
      final result = await weatherRepository.fetchWeather(cityName, dayCount);
      change(result, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error("Hata oluştu: $e"));
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}