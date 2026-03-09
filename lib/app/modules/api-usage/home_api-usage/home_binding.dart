import 'package:api_usage/app/modules/api-usage/home_api-usage/home.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut<HomeApiUsageController>(()=>HomeApiUsageController());

  }
}