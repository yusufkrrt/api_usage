// class NewsBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<NewsApiProvider>(() => NewsApiProvider());
//     Get.lazyPut<NewsRepository>(
//           () => NewsRepository(apiProvider: Get.find<NewsApiProvider>()),
//     );
//     Get.lazyPut<NewsController>(
//           () => NewsController(repository: Get.find<NewsRepository>()),
//     );
//   }
// }
import 'package:api_usage/app/data/repositories/weather_repository.dart';
import 'package:api_usage/app/modules/api-usage/weather/weather_controller.dart';
import 'package:get/get.dart';

import '../../../data/providers/weather_provider.dart';
class WeatherBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<WeatherProvider>(() => WeatherProvider());
    Get.lazyPut<WeatherRepository>(() => WeatherRepository(apiProvider: Get.find<WeatherProvider>()));
    Get.lazyPut<WeatherController>(() => WeatherController(weatherRepository: Get.find<WeatherRepository>()));

  }
}