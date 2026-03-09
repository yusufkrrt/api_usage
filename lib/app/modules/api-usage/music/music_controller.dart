import 'package:api_usage/app/data/models/music_model.dart';
import 'package:api_usage/app/data/repositories/music_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicController extends GetxController with StateMixin<MusicModel> {
  final MusicRepository repository;
  MusicController({required this.repository});

  final TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.empty());
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }

  void searchMusic(String query) async {
    if (query.trim().isEmpty) {
      change(null, status: RxStatus.empty());
      return;
    }

    change(null, status: RxStatus.loading());
    try {
      final result = await repository.searchMusic(query);
      if (result != null && result.results.isNotEmpty) {
        change(result, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } catch (e) {
      change(null, status: RxStatus.error('Müzikler getirilemedi'));
    }
  }
}