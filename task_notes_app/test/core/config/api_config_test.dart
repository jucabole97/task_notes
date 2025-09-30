import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_notes_app/core/config/api_config.dart';

void main() {
  group('ApiConfig', () {
    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await dotenv.load(fileName: 'test/.env');
    });

    test('baseUrl toma el valor de BASE_API si está definido', () {
      expect(ApiConfig.baseUrl, 'https://fake.api');
    });

    test('itemUrl siempre es "item"', () {
      expect(ApiConfig.itemUrl, 'item');
    });
  });
}
