import '../models/home_category_model.dart';

class HomeCategoryService {
  Future<List<HomeCategoryModel>> fetchCategories() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return const [
      HomeCategoryModel(
        id: 'dinner',
        title: 'Yemek Takımı',
        imageUrl: 'https://images.unsplash.com/photo-1610701596007-11502861dcfa?w=800',
      ),
      HomeCategoryModel(
        id: 'breakfast',
        title: 'Kahvaltı',
        imageUrl: 'https://images.unsplash.com/photo-1576020799627-aeac74d58064?w=800',
      ),
      HomeCategoryModel(
        id: 'ali',
        title: 'Al-i Serisi',
        imageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800',
      ),
      HomeCategoryModel(
        id: 'gallery',
        title: 'Galeri',
        imageUrl: 'https://images.unsplash.com/photo-1516594915697-87eb3b1c14ea?w=800',
      ),
    ];
  }

  Future<List<HomeCategoryModel>> fetchNewArrivals() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return const [
      HomeCategoryModel(
        id: 'new_1',
        title: 'Yeni Fincan Serisi',
        imageUrl: 'https://images.unsplash.com/photo-1572119865084-43c285814d63?w=600',
      ),
      HomeCategoryModel(
        id: 'new_2',
        title: 'Modern Tabaklar',
        imageUrl: 'https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?w=600',
      ),
    ];
  }
}
