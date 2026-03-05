import 'package:get/get.dart';

import 'data/services/network_service.dart';

class DependencyInjection {
  static void init() {
    // Örnek: Uygulama genelinde kullanılacak servisler
    Get.put<NetworkService>(NetworkService(), permanent: true);
  }
}