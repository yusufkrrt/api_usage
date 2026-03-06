

import 'package:api_usage/app/data/models/crypto_model.dart';

import '../providers/crypto_provider.dart';

class CryptoRepository {
  CryptoRepository({required this.apiProvider});
  final CryptoProvider apiProvider;
  Future<List<Datum>> fetchCryptos() async {
    try{
      final response = await apiProvider.getCryptos();
      if (response.statusCode == 200) {
        // CMC yapısında asıl liste "data" key'i içerisindedir
        final List<dynamic> rawData = response.data['data'];

        // Listeyi tek tek Datum nesnelerine dönüştürüyoruz
        return rawData.map((json) => Datum.fromJson(json)).toList();
      } else {
        throw Exception('Kripto verileri alınamadı: ${response.statusMessage}');
      }
    }catch(e){
      throw Exception("Repository Hatası $e");
    }

  }
}