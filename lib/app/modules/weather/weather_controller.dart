import 'package:flutter/material.dart'; // TextEditingController için gerekli
import 'package:get/get.dart';import '../../data/models/weather_model.dart';
import '../../data/repositories/weather_repository.dart';

class WeatherController extends GetxController with StateMixin<WeatherModel> {
  final WeatherRepository weatherRepository;
  WeatherController({required this.weatherRepository});

  // Şehir ismini tutan observable ve giriş kutusu için controller
  final city = 'Istanbul'.obs;
  final textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // city.value kullanarak string değere ulaşıyoruz
    getWeatherByCity(city.value);
  }

  // Yeni bir şehir aratıldığında çağrılacak fonksiyon
  void onSearchCity() {
    if (textController.text.isNotEmpty) {
      city.value = textController.text;
      getWeatherByCity(city.value);
    }
  }

  void getWeatherByCity(String cityName) async {
    change(null, status: RxStatus.loading());
    try {
      // API'den veriyi çek
      final result = await weatherRepository.fetchWeather(cityName, 1);
      change(result, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error("Şehir bulunamadı veya hata oluştu."));
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}