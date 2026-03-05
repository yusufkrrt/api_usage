

import 'package:api_usage/app/data/models/weather_model.dart';

import '../providers/weather_provider.dart';

class WeatherRepository {
  WeatherRepository({required this.apiProvider});
  final WeatherProvider apiProvider;
  Future<WeatherModel> fetchWeather(String city, int days) async {
    final response = await apiProvider.getWeather(city, days);
    if(response.statusCode == 200){
      return WeatherModel.fromJson(response.data);
    }else{
      throw Exception('Hata');
    }
  }
}

