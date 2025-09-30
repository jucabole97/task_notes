import 'package:get_it/get_it.dart';
import '../../task_notes.dart';

final sl = GetIt.instance;

void setupFakeDependencies() {
  sl.registerLazySingleton<ItemRepository>(() => ItemRepositoryMock());
  sl.registerLazySingleton<PushTokenRepository>(
    () => PushTokenRepositoryMock(),
  );
}
