import '../models/food_model.dart';
import '../providers/food_provider.dart';

class FoodRepository {
  FoodRepository({required this.apiProvider});
  final FoodProvider apiProvider;

  Future<FoodModel?> searchRecipes(String query) async {
    try {
      final response = await apiProvider.searchRecipes(query);
      if (response.statusCode == 200 && response.data != null) {
        return FoodModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print('FoodRepository Hatası: $e');
      throw Exception('Tarifler getirilemedi');
    }
  }
}