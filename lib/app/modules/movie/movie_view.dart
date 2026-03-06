import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'movie_controller.dart';

class MovieView extends GetView<MovieController> {
  const MovieView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Film Dünyası"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Arama Çubuğu
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: "Film ara...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.searchController.clear();
                    controller.fetchPopularMovies();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onSubmitted: (value) {
                controller.searchMovies(value);
              },
            ),
          ),
          
          // Film Listesi
          Expanded(
            child: controller.obx(
              (state) => ListView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: state?.length ?? 0,
                itemBuilder: (context, index) {
                  final movie = state![index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Film Afişi
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          child: movie.posterPath != null
                              ? Image.network(
                                  "https://image.tmdb.org/t/p/w200${movie.posterPath}",
                                  width: 100,
                                  height: 150,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 100,
                                  height: 150,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.movie, size: 40),
                                ),
                        ),
                        
                        // Film Bilgileri
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  movie.releaseDate,
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 20),
                                    const SizedBox(width: 4),
                                    Text(
                                      movie.voteAverage.toStringAsFixed(1),
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "(${movie.voteCount})",
                                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              onLoading: const Center(child: CircularProgressIndicator()),
              onEmpty: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.movie_filter, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text("Film bulunamadı."),
                  ],
                ),
              ),
              onError: (error) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(error ?? "Bir hata oluştu"),
                    ElevatedButton(
                      onPressed: () => controller.fetchPopularMovies(),
                      child: const Text("Tekrar Dene"),
                    )
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
