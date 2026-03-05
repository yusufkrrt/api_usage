import 'package:flutter_dotenv/flutter_dotenv.dart';

class CryptoProvider {
  static final String _apiKey = dotenv.env['CMC_API_KEY'] ?? '';

// Kullanırken: headers: { 'X-CMC_PRO_API_KEY': _apiKey }
}