import 'package:get_it/get_it.dart';
import 'package:task_notes_app/config/di/di_mock.dart';
import 'package:task_notes_app/config/di/di_testing.dart';

import '../../task_notes.dart';

final sl = GetIt.instance;

Future<void> setupDependencies({bool useFake = false}) async {
  await sl.reset();

  if (useFake) {
    setupFakeDependencies();
  } else {
    setupTestingDependencies();
  }

  // Use cases
  sl.registerLazySingleton<AddItemUseCase>(() => AddItemUseCase(sl()));
  sl.registerLazySingleton<GetItemsUseCase>(() => GetItemsUseCase(sl()));
  sl.registerLazySingleton<GetPushTokenUsecase>(
    () => GetPushTokenUsecase(sl()),
  );
  sl.registerLazySingleton<GetItemByIdUsecase>(() => GetItemByIdUsecase(sl()));

  // Presenters
  sl.registerLazySingleton(() => ItemDetailPresenter(sl()));
  sl.registerLazySingleton(() => SplashPresenter(sl()));
  sl.registerLazySingleton<ItemsPresenter>(
    () => ItemsPresenter(addItemUseCase: sl(), getItemsUseCase: sl()),
  );
}
