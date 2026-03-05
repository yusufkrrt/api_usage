import '../entities/home_category_entities.dart';
import '../models/home_category_model.dart';
import '../services/home_category_services.dart';

abstract class HomeCategoryRepository {
  Future<List<HomeCategoryEntity>> getCategories();
  Future<List<HomeCategoryEntity>> getNewArrivals();
}

class HomeCategoryRepositoryImpl implements HomeCategoryRepository {
  HomeCategoryRepositoryImpl(this._service);

  final HomeCategoryService _service;

  @override
  Future<List<HomeCategoryEntity>> getCategories() async {
    final List<HomeCategoryModel> models = await _service.fetchCategories();
    return models.map((item) => item.toEntity()).toList();
  }

  @override
  Future<List<HomeCategoryEntity>> getNewArrivals() async {
    final List<HomeCategoryModel> models = await _service.fetchNewArrivals();
    return models.map((item) => item.toEntity()).toList();
  }
}
