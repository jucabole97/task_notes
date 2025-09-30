import 'package:get_it/get_it.dart';
import '../../task_notes.dart';

final sl = GetIt.instance;

void setupTestingDependencies() {
  sl.registerLazySingleton<ApiService>(() => ApiServiceImpl());
  sl.registerLazySingleton<ItemRepository>(() => ItemRepositoryImpl(sl()));
  sl.registerLazySingleton<PushTokenRepository>(
    () => PushTokenRepositoryImpl(),
  );
}
