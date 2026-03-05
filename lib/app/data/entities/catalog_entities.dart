class CatalogEntities {
  const CatalogEntities({
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
}