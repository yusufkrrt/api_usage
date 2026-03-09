
import 'package:api_usage/app/data/providers/music_provider.dart';
import 'package:api_usage/app/data/repositories/music_repository.dart';
import 'package:api_usage/app/modules/api-usage/music/music.dart';
import 'package:get/get.dart';

class MusicBinding extends Bindings{
  
  @override
  void dependencies() {
    Get.lazyPut<MusicProvider>(()=> MusicProvider());
    Get.lazyPut<MusicRepository>(()=> MusicRepository(apiProvider: Get.find<MusicProvider>()));
    Get.lazyPut<MusicController>(()=> MusicController(repository: Get.find<MusicRepository>()));
  }
}
class MusicDetailBinding extends Bindings{
  
  @override
  void dependencies() {
    Get.lazyPut<MusicProvider>(()=> MusicProvider());
    Get.lazyPut<MusicRepository>(()=> MusicRepository(apiProvider: Get.find<MusicProvider>()));
    Get.lazyPut<MusicDetailController>(()=> MusicDetailController(repository: Get.find<MusicRepository>()));
  }
}