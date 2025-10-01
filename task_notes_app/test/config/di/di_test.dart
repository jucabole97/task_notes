import 'package:flutter_test/flutter_test.dart';
import 'package:task_notes_app/task_notes.dart';

void main() {
  test('setupDependencies registra instancias reales', () async {
    await setupDependencies();

    expect(sl.isRegistered<ApiService>(), true);
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

    expect(sl.isRegistered<ApiService>(), false);
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
