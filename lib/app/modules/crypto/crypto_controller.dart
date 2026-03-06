import 'package:api_usage/app/data/models/crypto_model.dart';import 'package:api_usage/app/data/repositories/crypto_repository.dart';
import 'package:get/get.dart';

class CryptoController extends GetxController with StateMixin<List<Datum>> {
  final CryptoRepository cryptoRepository;
  CryptoController({required this.cryptoRepository});

  @override
  void onInit() {
    super.onInit();
    fetchCryptoData(); // Uygulama açıldığında veriyi çek
  }

  // Veriyi çeken ana fonksiyon
  Future<void> fetchCryptoData() async {
    change(null, status: RxStatus.loading()); // Yükleniyor durumuna al
    try {
      final List<Datum> result = await cryptoRepository.fetchCryptos();

      if (result.isEmpty) {
        change(null, status: RxStatus.empty());
      } else {
        change(result, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error("Kripto verileri alınamadı: $e"));
    }
  }
}