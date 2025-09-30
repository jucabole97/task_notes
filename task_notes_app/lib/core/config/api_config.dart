import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static final String baseUrl = dotenv.env['BASE_API'] ?? '';
  static final String itemUrl = 'item';
}
