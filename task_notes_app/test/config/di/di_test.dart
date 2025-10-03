import 'package:flutter_test/flutter_test.dart';
import 'package:task_notes_app/task_notes.dart';

void main() {
  test('setupDependencies registra instancias reales', () async {
    await setupDependencies();

    expect(sl.isRegistered<GetService>(), true);
    expect(sl.isRegistered<GetByIdService>(), true);
    expect(sl.isRegistered<PostService>(), true);
    expect(sl.isRegistered<PutService>(), true);
    expect(sl.isRegistered<DeleteService>(), true);
    expect(sl.isRegistered<ItemRepository>(), true);
    expect(sl.isRegistered<PushTokenRepository>(), true);
    expect(sl.isRegistered<ItemDetailPresenter>(), true);
    expect(sl.isRegistered<SplashPresenter>(), true);
    expect(sl.isRegistered<ItemsPresenter>(), true);
    expect(sl.isRegistered<AddItemUseCase>(), true);
    expect(sl.isRegistered<GetItemsUseCase>(), true);
    expect(sl.isRegistered<GetPushTokenUsecase>(), true);
    expect(sl.isRegistered<GetItemByIdUsecase>(), true);
  });

  test('setupDependencies registra instancias mock', () async {
    await setupDependencies(useFake: true);

    expect(sl.isRegistered<GetService>(), false);
    expect(sl.isRegistered<GetByIdService>(), false);
    expect(sl.isRegistered<PostService>(), false);
    expect(sl.isRegistered<PutService>(), false);
    expect(sl.isRegistered<DeleteService>(), false);
    expect(sl.isRegistered<ItemRepository>(), true);
    expect(sl.isRegistered<PushTokenRepository>(), true);
    expect(sl.isRegistered<ItemDetailPresenter>(), true);
    expect(sl.isRegistered<SplashPresenter>(), true);
    expect(sl.isRegistered<ItemsPresenter>(), true);
    expect(sl.isRegistered<AddItemUseCase>(), true);
    expect(sl.isRegistered<GetItemsUseCase>(), true);
    expect(sl.isRegistered<GetPushTokenUsecase>(), true);
    expect(sl.isRegistered<GetItemByIdUsecase>(), true);
  });
}
