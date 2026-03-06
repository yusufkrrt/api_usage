
import 'package:api_usage/app/data/providers/crypto_provider.dart';
import 'package:api_usage/app/data/repositories/crypto_repository.dart';
import 'package:api_usage/app/modules/crypto/crypto_controller.dart';
import 'package:get/get.dart';

class CryptoBinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut<CryptoProvider>( () => CryptoProvider());
    Get.lazyPut<CryptoRepository>(()=>CryptoRepository(apiProvider: Get.find<CryptoProvider>()));
    Get.lazyPut<CryptoController>(() => CryptoController(cryptoRepository: Get.find<CryptoRepository>()));
  }
}