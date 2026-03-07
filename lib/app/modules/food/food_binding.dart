import 'package:api_usage/app/data/providers/food_provider.dart';
import 'package:api_usage/app/data/repositories/food_repository.dart';
import 'package:api_usage/app/modules/food/food_controller.dart';
import 'package:get/get.dart';

class FoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FoodProvider());
    Get.lazyPut(() => FoodRepository(apiProvider: Get.find()));
    Get.lazyPut(() => FoodController(foodRepository: Get.find()));
  }
}