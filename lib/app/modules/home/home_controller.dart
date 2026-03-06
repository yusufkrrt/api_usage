import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final List<String> apiList = [
    "News API",
    "Weather API",
    "Crypto API",
    "Movie API",
    "Food API -soon",
    "Joke API-soon",
    "Quotes API-soon",
    "User API-soon",
    "Image API-soon",
    "Music API-soon",
  ];
  void onApiItemSelected(int index) {
    final selectedApi = apiList[index];

    debugPrint("$selectedApi tıklandı");

    switch (selectedApi) {
      case "News API":
        Get.toNamed('/news');
      case "Weather API":
        Get.toNamed("/weather");
        break;
      case "Crypto API":
        Get.toNamed("/crypto");
        break;
      case "Movie API":
        Get.toNamed("/movie");
        break;
      // Add more cases for other APIs as needed
      //"
      // case "Weather API":
      //   Get.toNamed('/weather');
      //   break;
      default:
        Get.snackbar("Bilgi", "Bu sayfa henüz hazır değil.");
    }
  }
}
