import 'package:get/get.dart';
import '../models/music_model.dart';
import '../providers/music_provider.dart';

class MusicRepository {
  MusicRepository({required this.apiProvider});
  final MusicProvider apiProvider;

  Future<MusicModel?> searchMusic(String query) async {
    try {
      final response = await apiProvider.searchMusic(query);
      if (response.statusCode == 200 && response.data != null) {
        return MusicModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print('MusicRepository Hatası: $e');
      throw Exception('Müzikler getirilemedi');
    }
  }

  Future<MusicModel?> getMusicDetails(String id) async {
    try {
      final response = await apiProvider.getMusicDetails(id);
      if (response.statusCode == 200 && response.data != null) {
        return MusicModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print('MusicRepository Hatası: $e');
      throw Exception('Müzik detayları getirilemedi');
    }
  }
}