import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_notes_app/infrastructure/infrastructure.dart';
import 'package:task_notes_app/task_notes.dart';

import '../../mocks/mocks.dart';

void main() {
  late MockHttpClient mockClient;
  late MockHttpClientRequest mockRequest;
  late MockHttpClientResponse mockResponse;
  late MockHttpHeaders mockHeaders;
  late ApiServiceImpl api;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: 'test/.env');

    mockClient = MockHttpClient();
    mockRequest = MockHttpClientRequest();
    mockResponse = MockHttpClientResponse();
    mockHeaders = MockHttpHeaders();

    when(() => mockRequest.headers).thenReturn(mockHeaders);
    when(() => mockHeaders.contentType).thenReturn(ContentType.json);
    when(() => mockHeaders.contentType = any()).thenReturn(null);

    api = ApiServiceImpl(client: mockClient);

    registerFallbackValue(Uri());
  });

  group('Get tests', () {
    test('GET devuelve Map cuando status 200 y body es objeto', () async {
      final body = '{"id":1,"name":"test"}';

      when(() => mockClient.getUrl(any())).thenAnswer((_) async => mockRequest);
      when(() => mockRequest.close()).thenAnswer((_) async => mockResponse);
      when(() => mockResponse.statusCode).thenReturn(200);
      when(
        () => mockResponse.transform(utf8.decoder),
      ).thenAnswer((_) => Stream.value(body));

      final result = await api.get('/items');

      expect(result, isA<Map<String, dynamic>>());
      expect(result['id'], 1);
      expect(result['name'], 'test');
    });

    test('GET devuelve List cuando status 200 y body es lista', () async {
      final body = '[{"id":1},{"id":2}]';

      when(() => mockClient.getUrl(any())).thenAnswer((_) async => mockRequest);
      when(() => mockRequest.close()).thenAnswer((_) async => mockResponse);
      when(() => mockResponse.statusCode).thenReturn(200);
      when(
        () => mockResponse.transform(utf8.decoder),
      ).thenAnswer((_) => Stream.value(body));

      final result = await api.get('/items', isList: true);

      expect(result, isA<List<Map<String, dynamic>>>());
      expect(result.length, 2);
    });

    test('GET devuelve {} cuando body vacío y isList=false', () async {
      when(() => mockClient.getUrl(any())).thenAnswer((_) async => mockRequest);
      when(() => mockRequest.close()).thenAnswer((_) async => mockResponse);
      when(() => mockResponse.statusCode).thenReturn(200);
      when(
        () => mockResponse.transform(utf8.decoder),
      ).thenAnswer((_) => const Stream.empty());

      final result = await api.get('/items');

      expect(result, isA<Map<String, dynamic>>());
      expect(result, isEmpty);
    });

    test('GET devuelve [] cuando body vacío y isList=true', () async {
      when(() => mockClient.getUrl(any())).thenAnswer((_) async => mockRequest);
      when(() => mockRequest.close()).thenAnswer((_) async => mockResponse);
      when(() => mockResponse.statusCode).thenReturn(200);
      when(
        () => mockResponse.transform(utf8.decoder),
      ).thenAnswer((_) => const Stream.empty());

      final result = await api.get('/items', isList: true);

      expect(result, isA<List<Map<String, dynamic>>>());
      expect(result, isEmpty);
    });

    test('lanza HttpException cuando status >=400', () async {
      when(() => mockClient.getUrl(any())).thenAnswer((_) async => mockRequest);
      when(() => mockRequest.close()).thenAnswer((_) async => mockResponse);
      when(() => mockResponse.statusCode).thenReturn(404);
      when(
        () => mockResponse.transform(utf8.decoder),
      ).thenAnswer((_) => Stream.value('Not found'));

      expect(() => api.get('/items'), throwsA(isA<HttpException>()));
    });

    test('lanza FormatException cuando body no es JSON válido', () async {
      when(() => mockClient.getUrl(any())).thenAnswer((_) async => mockRequest);
      when(() => mockRequest.close()).thenAnswer((_) async => mockResponse);
      when(() => mockResponse.statusCode).thenReturn(200);
      when(
        () => mockResponse.transform(utf8.decoder),
      ).thenAnswer((_) => Stream.value('texto plano'));

      expect(() => api.get('/items'), throwsA(isA<FormatException>()));
    });
  });

  group('Get by id tests', () {
    test('getById delega en get', () async {
      final body = '{"id": 1, "name": "test"}';
      when(() => mockClient.getUrl(any())).thenAnswer((_) async => mockRequest);
      when(() => mockRequest.close()).thenAnswer((_) async => mockResponse);
      when(() => mockResponse.statusCode).thenReturn(200);
      when(
        () => mockResponse.transform(utf8.decoder),
      ).thenAnswer((_) => Stream.value(body));

      final result = await api.getById('items', '1');

      expect(result, {'id': 1, 'name': 'test'});
      verify(() => mockClient.getUrl(any())).called(1);
      verify(() => mockRequest.close()).called(1);
    });

    test('lanza HttpException cuando status >=400', () async {
      when(() => mockClient.getUrl(any())).thenAnswer((_) async => mockRequest);
      when(() => mockRequest.close()).thenAnswer((_) async => mockResponse);
      when(() => mockResponse.statusCode).thenReturn(404);
      when(
        () => mockResponse.transform(utf8.decoder),
      ).thenAnswer((_) => Stream.value('Not found'));

      expect(() => api.getById('/items', '1'), throwsA(isA<HttpException>()));
    });

    test('lanza FormatException cuando body no es JSON válido', () async {
      when(() => mockClient.getUrl(any())).thenAnswer((_) async => mockRequest);
      when(() => mockRequest.close()).thenAnswer((_) async => mockResponse);
      when(() => mockResponse.statusCode).thenReturn(200);
      when(
        () => mockResponse.transform(utf8.decoder),
      ).thenAnswer((_) => Stream.value('texto plano'));

      expect(() => api.getById('/items', '1'), throwsA(isA<FormatException>()));
    });
  });

  group('Post tests', () {
    test('devuelve Map cuando status 200 y body es objeto', () async {
      final body = {'name': 'Julian'};
      final responseBody = '{"id":1,"name":"Julian"}';

      when(
        () => mockClient.postUrl(any()),
      ).thenAnswer((_) async => mockRequest);
      when(() => mockRequest.write(any())).thenReturn(null);
      when(() => mockRequest.close()).thenAnswer((_) async => mockResponse);
      when(() => mockResponse.statusCode).thenReturn(200);
      when(
        () => mockResponse.transform(utf8.decoder),
      ).thenAnswer((_) => Stream.value(responseBody));

      final result = await api.post('/items', body);

      expect(result, isA<Map<String, dynamic>>());
      expect(result['id'], 1);
      expect(result['name'], 'Julian');
    });

    test('devuelve List cuando status 200 y body es lista', () async {
      final body = {'foo': 'bar'};
      final responseBody = '[{"id":1},{"id":2}]';

      when(
        () => mockClient.postUrl(any()),
      ).thenAnswer((_) async => mockRequest);
      when(() => mockRequest.write(any())).thenReturn(null);
      when(() => mockRequest.close()).thenAnswer((_) async => mockResponse);
      when(() => mockResponse.statusCode).thenReturn(200);
      when(
        () => mockResponse.transform(utf8.decoder),
      ).thenAnswer((_) => Stream.value(responseBody));

      final result = await api.post('/items', body);

      expect(result, isA<List<Map<String, dynamic>>>());
      expect(result.length, 2);
    });

    test('devuelve {} cuando body vacío', () async {
      final body = {'foo': 'bar'};

      when(
        () => mockClient.postUrl(any()),
      ).thenAnswer((_) async => mockRequest);
      when(() => mockRequest.write(any())).thenReturn(null);
      when(() => mockRequest.close()).thenAnswer((_) async => mockResponse);
      when(() => mockResponse.statusCode).thenReturn(200);
      when(
        () => mockResponse.transform(utf8.decoder),
      ).thenAnswer((_) => const Stream.empty());

      final result = await api.post('/items', body);

      expect(result, isA<Map<String, dynamic>>());
      expect(result, isEmpty);
    });

    test('lanza HttpException cuando status >=400', () async {
      final body = {'foo': 'bar'};

      when(
        () => mockClient.postUrl(any()),
      ).thenAnswer((_) async => mockRequest);
      when(() => mockRequest.write(any())).thenReturn(null);
      when(() => mockRequest.close()).thenAnswer((_) async => mockResponse);
      when(() => mockResponse.statusCode).thenReturn(400);
      when(
        () => mockResponse.transform(utf8.decoder),
      ).thenAnswer((_) => Stream.value('Bad request'));

      expect(() => api.post('/items', body), throwsA(isA<HttpException>()));
    });

    test('lanza FormatException cuando body no es JSON válido', () async {
      final body = {'foo': 'bar'};

      when(
        () => mockClient.postUrl(any()),
      ).thenAnswer((_) async => mockRequest);
      when(() => mockRequest.write(any())).thenReturn(null);
      when(() => mockRequest.close()).thenAnswer((_) async => mockResponse);
      when(() => mockResponse.statusCode).thenReturn(200);
      when(
        () => mockResponse.transform(utf8.decoder),
      ).thenAnswer((_) => Stream.value('texto plano'));

      expect(() => api.post('/items', body), throwsA(isA<FormatException>()));
    });
  });
}
