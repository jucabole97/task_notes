import 'package:get_it/get_it.dart';
import '../../task_notes.dart';

final sl = GetIt.instance;

void setupTestingDependencies() {
  sl.registerLazySingleton<GetService>(() => ApiServiceImpl());
  sl.registerLazySingleton<GetByIdService>(() => ApiServiceImpl());
  sl.registerLazySingleton<PostService>(() => ApiServiceImpl());
  sl.registerLazySingleton<PutService>(() => ApiServiceImpl());
  sl.registerLazySingleton<DeleteService>(() => ApiServiceImpl());
  sl.registerLazySingleton<ItemRepository>(
    () => ItemRepositoryImpl(sl(), sl(), sl()),
  );
  sl.registerLazySingleton<PushTokenRepository>(
    () => PushTokenRepositoryImpl(),
  );
}
