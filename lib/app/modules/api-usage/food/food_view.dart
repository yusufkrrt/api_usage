import 'package:api_usage/app/modules/api-usage/food/food_controller.dart';
import 'package:api_usage/app/data/models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodScreen extends GetView<FoodController> {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🍽️ Tarifler'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ARAMA ALANI
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: controller.textController,
              decoration: InputDecoration(
                hintText: 'Tarif ara... (pasta, burger...)',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.textController.clear();
                    controller.searchRecipes('');
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
              onSubmitted: (value) {
                // Klavyeden Enter'a basınca arama yap
                controller.searchRecipes(value.trim());
              },
            ),
          ),

          // LİSTE ALANI
          Expanded(
            child: controller.obx(
                  (state) => ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: state!.results.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final recipe = state.results[index];
                  return _FoodCard(recipe: recipe);
                },
              ),
              onLoading: const Center(child: CircularProgressIndicator()),
              onEmpty: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.no_food, size: 64, color: Colors.grey),
                    SizedBox(height: 12),
                    Text('Tarif bulunamadı'),
                  ],
                ),
              ),
              onError: (err) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 12),
                    Text(err ?? 'Bir hata oluştu'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => controller.searchRecipes(''),
                      child: const Text('Tekrar Dene'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FoodCard extends StatelessWidget {
  final Result recipe;

  const _FoodCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Resim
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              recipe.image,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 180,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.fastfood, size: 48, color: Colors.grey),
                ),
              ),
            ),
          ),

          // İçerik
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Başlık
                Text(
                  recipe.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // Alt bilgi satırı
                Row(
                  children: [
                    const Icon(Icons.timer, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      '${recipe.readyInMinutes} dk',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.people, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      '${recipe.servings} kişilik',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const Spacer(),
                    const Icon(Icons.favorite, size: 14, color: Colors.red),
                    const SizedBox(width: 4),
                    Text(
                      '${recipe.aggregateLikes}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}