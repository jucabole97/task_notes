📘 task_notes_app – Arquitectura y Organización

🚀 Visión General

Este proyecto sigue una arquitectura limpia (Clean Architecture) con influencias de MVP/MVVM, separando responsabilidades en capas bien definidas:

- UI → Presentación y estado reactivo.
- Domain → Reglas de negocio, entidades y casos de uso.
- Infrastructure → Implementaciones concretas (API, DB, mappers).
- Core → Servicios transversales y configuración global.

📂 Estructura de Carpetas

lib/
 ├── core/              # Servicios y utilidades transversales
 │    ├── constants/
 │    ├── services/     # Ej: deeplink_service, notification_service
 │    └── theme/
 │
 ├── domain/            # Capa de negocio
 │    ├── entities/     # Modelos puros
 │    ├── factories/    # Creación controlada de objetos
 │    ├── patterns/     # Ejemplos de patrones GoF
 │    ├── repositories/ # Repositorios abstractos
 │    ├── services/     # Interfaces de servicios
 │    └── usecases/     # Casos de uso
 │
 ├── infrastructure/    # Implementaciones concretas
 │    ├── api/          # ApiService con HttpClient
 │    ├── db/           # Persistencia local (Prueba)
 │    ├── mappers/      # Transformación DTO ↔ Entidad
 │    └── repositories_impl/
 │
 ├── ui/                # Presentación
 │    ├── constants/
 │    ├── extensions/
 │    ├── notifiers/    # Manejo de estado (ChangeNotifier)
 │    ├── presenters/   # Lógica de presentación
 │    ├── screens/      # Pantallas
 │    └── widgets/      # Componentes UI reutilizables
 │
 ├── app.dart           # Configuración principal de la app
 ├── main_dev.dart      # Entry point dev
 └── main_prod.dart     # Entry point prod

🔄 Flujo de Dependencias

- UI (Notifiers/Presenters) → llaman a UseCases.
- UseCases → dependen de Repositories (abstractos).
- Repositories → implementados en Infrastructure (API, DB).
- Core → provee DI, rutas y servicios globales.

🛠 Inyección de Dependencias

- Se usa get_it en config/di.dart:
- Se registran implementaciones concretas (ItemRepositoryImpl, ApiServiceImpl).
- Se exponen como abstracciones (ItemRepository, GetService, PostService).
- La UI recibe Presenter y Notifier ya configurados.

👉 Consideraciones:

Para ejecutar deeplink desde terminal:

- adb shell am start -a android.intent.action.VIEW -d "task-notes-app://note/1" com.example.task_notes_app

Para ejecutar test de integración:

- flutter drive --driver integration_test/integration_test_driver.dart --target integration_test/splash/splash_screen.dart --flavor dev -t lib/main_dev.dart -d SM M236B