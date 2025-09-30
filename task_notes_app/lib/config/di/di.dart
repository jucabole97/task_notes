import 'package:get_it/get_it.dart';

import '../../task_notes.dart';

final sl = GetIt.instance;

void setupDependencies({bool useFake = false}) {
  if (useFake) {
    sl.registerLazySingleton<ApiService>(() => ApiService());
    sl.registerLazySingleton<ItemRepository>(() => ItemRepositoryImpl(sl()));
    sl.registerLazySingleton<AddItemUseCase>(() => AddItemUseCase(sl()));
    sl.registerLazySingleton<GetItemsUseCase>(() => GetItemsUseCase(sl()));
    sl.registerLazySingleton<PushTokenRepository>(
      () => PushTokenRepositoryImpl(),
    );
    sl.registerLazySingleton<GetPushTokenUsecase>(
      () => GetPushTokenUsecase(sl()),
    );
    sl.registerLazySingleton<GetItemByIdUsecase>(
      () => GetItemByIdUsecase(sl()),
    );
  } else {
    sl.registerLazySingleton<ApiService>(() => ApiService());
    sl.registerLazySingleton<ItemRepository>(() => ItemRepositoryImpl(sl()));
    sl.registerLazySingleton<AddItemUseCase>(() => AddItemUseCase(sl()));
    sl.registerLazySingleton<GetItemsUseCase>(() => GetItemsUseCase(sl()));
    sl.registerLazySingleton<PushTokenRepository>(
      () => PushTokenRepositoryImpl(),
    );
    sl.registerLazySingleton<GetPushTokenUsecase>(
      () => GetPushTokenUsecase(sl()),
    );
    sl.registerLazySingleton<GetItemByIdUsecase>(
      () => GetItemByIdUsecase(sl()),
    );
  }
  sl.registerLazySingleton<ItemsPresenter>(
    () => ItemsPresenter(addItemUseCase: sl(), getItemsUseCase: sl()),
  );
  sl.registerLazySingleton(() => ItemDetailPresenter(sl()));
  sl.registerLazySingleton(() => SplashPresenter(sl()));
}
