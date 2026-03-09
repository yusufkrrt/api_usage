import 'package:api_usage/app/data/models/music_model.dart';
import 'package:api_usage/app/data/repositories/music_repository.dart';
import 'package:get/get.dart';

class MusicDetailController extends GetxController with StateMixin<Result> {
  final MusicRepository repository;
  MusicDetailController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    final trackId = Get.arguments?.toString();
    if (trackId != null) {
      fetchMusicDetail(trackId);
    } else {
      change(null, status: RxStatus.error('Track ID bulunamadı'));
    }
  }

  void fetchMusicDetail(String id) async {
    change(null, status: RxStatus.loading());
    try {
      final result = await repository.getMusicDetails(id);
      if (result != null && result.results.isNotEmpty) {
        change(result.results.first, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } catch (e) {
      change(null, status: RxStatus.error('Müzik detayı getirilemedi'));
    }
  }
}
