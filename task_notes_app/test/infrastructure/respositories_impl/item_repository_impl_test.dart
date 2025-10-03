import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_notes_app/task_notes.dart';

import '../../mocks/mocks.dart';

void main() {
  late MockGetService mockGetApi;
  late MockGetByIdService mockGetByIdApi;
  late MockPostService mockPostApi;
  late ItemRepositoryImpl repository;

  setUp(() {
    mockGetApi = MockGetService();
    mockGetByIdApi = MockGetByIdService();
    mockPostApi = MockPostService();
    repository = ItemRepositoryImpl(mockGetApi, mockGetByIdApi, mockPostApi);
  });

  group('ItemRepositoryImpl', () {
    test('addItem llama a ApiService.post con el JSON correcto', () async {
      final note = Note(id: 1, title: 'Nota', content: 'Contenido');

      when(
        () => mockPostApi.post(ApiConfig.itemUrl, any()),
      ).thenAnswer((_) async => {});

      await repository.addItem(note);

      verify(
        () => mockPostApi.post(ApiConfig.itemUrl, ItemMapper.toJson(note)),
      ).called(1);
    });

    test('getAllItems devuelve lista de Items desde JSON', () async {
      final jsonList = [
        {
          'type': 'note',
          'id': 1,
          'title': 'Nota',
          'content': 'Contenido',
          'token': null,
        },
        {
          'type': 'task',
          'id': 2,
          'title': 'Tarea',
          'image': 'img123',
          'token': null,
        },
      ];

      when(
        () => mockGetApi.get(ApiConfig.itemUrl, isList: true),
      ).thenAnswer((_) async => jsonList);

      final result = await repository.getAllItems();

      expect(result, hasLength(2));
      expect(result[0], isA<Note>());
      expect(result[1], isA<Task>());
    });

    test('getById devuelve un Item cuando la respuesta es Map', () async {
      final json = {
        'type': 'note',
        'id': 1,
        'title': 'Nota',
        'content': 'Contenido',
      };

      when(
        () => mockGetByIdApi.getById(ApiConfig.itemUrl, '1'),
      ).thenAnswer((_) async => json);

      final result = await repository.getById('1');

      expect(result, isA<Note>());
      expect((result as Note).title, 'Nota');
    });

    test('getById devuelve EmptyItem cuando la respuesta no es Map', () async {
      when(
        () => mockGetByIdApi.getById(ApiConfig.itemUrl, '99'),
      ).thenAnswer((_) async => 'string inesperado');

      final result = await repository.getById('99');

      expect(result, isA<EmptyItem>());
    });
  });
}
