import '../entities/home_category_entities.dart';
import '../repositories/home_category_repositories.dart';

class GetHomeCategoriesUseCase {
  GetHomeCategoriesUseCase(this._repository);

  final HomeCategoryRepository _repository;

  Future<List<HomeCategoryEntity>> call() {
    return _repository.getCategories();
  }
}

class GetNewArrivalsUseCase {
  GetNewArrivalsUseCase(this._repository);

  final HomeCategoryRepository _repository;

  Future<List<HomeCategoryEntity>> call() {
    return _repository.getNewArrivals();
  }
}
