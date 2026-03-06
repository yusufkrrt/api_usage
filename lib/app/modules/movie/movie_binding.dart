
import 'package:api_usage/app/data/providers/movie_provider.dart';
import 'package:api_usage/app/data/repositories/movie_repository.dart';
import 'package:api_usage/app/modules/movie/movie_controller.dart';
import 'package:get/get.dart';

class MovieBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MovieProvider>(()=>MovieProvider());
    Get.lazyPut<MovieRepository>(()=>MovieRepository(apiProvider: Get.find<MovieProvider>()));
    Get.lazyPut<MovieController>(()=>MovieController(movieRepository: Get.find<MovieRepository>()));
  }

}