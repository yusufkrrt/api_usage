import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'app/di.dart';
import 'app/routes/routes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  try {
    await dotenv.load(fileName: ".env");
    debugPrint(".env dosyası başarıyla yüklendi");
  } catch (e) {
    debugPrint(".env dosyası yüklenirken hata oluştu: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News API Learning',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}