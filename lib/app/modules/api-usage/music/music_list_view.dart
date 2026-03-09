import 'package:api_usage/app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'music_controller.dart';

class MusicListView extends GetView<MusicController> {
  const MusicListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Müzik Arama',
        onRefresh: () => controller.searchMusic(controller.textController.text),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        controller: controller.textController,
        decoration: InputDecoration(
          hintText: 'Şarkı veya sanatçı ara...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => controller.textController.clear(),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        onSubmitted: (value) => controller.searchMusic(value),
        textInputAction: TextInputAction.search,
      ),
    );
  }

  Widget _buildBody() {
    return controller.obx(
      (state) => ListView.builder(
        itemCount: state!.results.length,
        itemBuilder: (context, index) {
          final music = state.results[index];
          return ListTile(
            title: Text(music.trackName ?? 'Bilinmeyen Parça'),
            subtitle: Text(music.artistName ?? 'Bilinmeyen Sanatçı'),
            onTap: () {
              Get.toNamed('/musicDetail', arguments: music.trackId?.toString());
            },
          );
        },
      ),
      onLoading: const Center(child: CircularProgressIndicator()),
      onEmpty: const Center(child: Text('Sonuç bulunamadı')),
      onError: (error) => Center(child: Text(error ?? 'Bir hata oluştu')),
    );
  }
}