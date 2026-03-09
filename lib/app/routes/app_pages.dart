import 'package:api_usage/app/modules/api-usage/crypto/crypto_binding.dart';
import 'package:api_usage/app/modules/api-usage/crypto/crypto_viev.dart';
import 'package:api_usage/app/modules/api-usage/food/food_binding.dart';
import 'package:api_usage/app/modules/api-usage/food/food_view.dart';
import 'package:api_usage/app/modules/api-usage/home_api-usage/home.dart';
import 'package:api_usage/app/modules/api-usage/home_api-usage/home_view.dart';
import 'package:api_usage/app/modules/api-usage/movie/movie_binding.dart';
import 'package:api_usage/app/modules/api-usage/movie/movie_view.dart';
import 'package:api_usage/app/modules/api-usage/weather/weather_view.dart';
import '../modules/animations/animations_home.dart';
import '../modules/playground/playground_home.dart';
import 'package:get/get.dart';
import '../modules/api-usage/music/music_binding.dart';
import '../modules/api-usage/music/music_detail_view.dart';
import '../modules/api-usage/music/music_list_view.dart';
import '../modules/api-usage/news/bindings/news_binding.dart';
import '../modules/api-usage/news/views/news_list_view.dart';
import '../modules/api-usage/news/views/news_detail_view.dart';
import '../modules/api-usage/weather/weather_binding.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.playground;

  static final routes = [
    GetPage(
      name: AppRoutes.playground,
      page: () => const PlaygroundHome(),
    ),
    GetPage(
      name: AppRoutes.animations,
      page: () => const AnimationsHome(),
    ),
    GetPage(
      name: AppRoutes.newsList,
      page: () => const NewsListView(),
      binding: NewsBinding(),
    ),
    GetPage(
      name: AppRoutes.newsDetail,
      page: () => const NewsDetailView(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeApiUsageScreen(),
      binding: HomeBinding()
    ),
    GetPage(
      name: AppRoutes.weather,
      page: () => WeatherScreen(),
      binding: WeatherBinding()
    ),
    GetPage(
      name: AppRoutes.crypto,
      page: () => CryptoScreen(),
      binding: CryptoBinding()
    ),
    GetPage(
      name: AppRoutes.movie,
      page: () => MovieView(),
      binding: MovieBinding()
    ),
    GetPage(
      name: AppRoutes.food,
      page: () => FoodScreen(),
      binding: FoodBinding()
    ),
    GetPage(
      name: AppRoutes.musicList,
      page: () => MusicListView(),
      binding: MusicBinding(),
    ),
    GetPage(
      name: AppRoutes.musicDetail,
      page: () => const MusicDetailView(),
      binding: MusicDetailBinding(),
    ),
  ];
}
