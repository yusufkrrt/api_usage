import '../entities/home_category_entities.dart';

class HomeCategoryModel {
  const HomeCategoryModel({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String imageUrl;

  HomeCategoryEntity toEntity() {
    return HomeCategoryEntity(id: id, title: title, imageUrl: imageUrl);
  }
}