import 'package:api_usage/app/data/models/food_model.dart';
import 'package:api_usage/app/data/repositories/food_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodController extends GetxController with StateMixin<FoodModel> {
  final FoodRepository foodRepository;
  FoodController({required this.foodRepository});

  final textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    searchRecipes(''); // Başlangıçta boş query ile popüler tarifleri getir
  }

  @override
  void onClose() {
    textController.dispose(); // Memory leak önlemek için dispose et
    super.onClose();
  }

  Future<void> searchRecipes(String query) async {
    change(null, status: RxStatus.loading());
    try {
      final FoodModel? result = await foodRepository.searchRecipes(query);
      if (result == null || result.results.isEmpty) {
        change(null, status: RxStatus.empty());
      } else {
        change(result, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error('Tarifler getirilemedi'));
    }
  }
}