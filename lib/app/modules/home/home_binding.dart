import 'package:api_usage/app/modules/home/home.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut<HomeController>(()=>HomeController());

  }
}