import 'package:get/get.dart';
import '../../../data/providers/news_api_provider.dart';
import '../../../data/repositories/news_repository.dart';
import '../controllers/news_controller.dart';

class NewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsApiProvider>(() => NewsApiProvider());
    Get.lazyPut<NewsRepository>(
      () => NewsRepository(apiProvider: Get.find<NewsApiProvider>()),
    );
    Get.lazyPut<NewsController>(
      () => NewsController(repository: Get.find<NewsRepository>()),
    );
  }
}