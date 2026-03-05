import '../entities/catalog_entities.dart';

class CatalogModel {
  const CatalogModel({
    required this.id,
    required this.label,
    required this.price,
    required this.describe,
    required this.title,

  });
  final String id;
  final String label;
  final double price;
  final String describe;
  final String title;

  CatalogEntities toEntity() {
    return CatalogEntities(
      id: id,
      label: label,
      price: price,
      describe: describe,
      title: title,
    );
  }
}
