import 'package:api_usage/app/modules/crypto/crypto_binding.dart';
import 'package:api_usage/app/modules/crypto/crypto_viev.dart';
import 'package:api_usage/app/modules/home/home.dart';
import 'package:api_usage/app/modules/home/home_view.dart';
import 'package:api_usage/app/modules/movie/movie_binding.dart';
import 'package:api_usage/app/modules/movie/movie_view.dart';
import 'package:api_usage/app/modules/weather/weather_view.dart';
import 'package:get/get.dart';
import '../modules/news/bindings/news_binding.dart';
import '../modules/news/views/news_list_view.dart';
import '../modules/news/views/news_detail_view.dart';
import '../modules/weather/weather_binding.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.home;

  static final routes = [
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
      page: () => const HomeScreen(),
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
    //add more pages here as needed
  ];
}
