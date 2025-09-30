abstract class SaveItemTemplate {
  void save() {
    validate();
    persist();
    notify();
  }

  void validate();
  void persist();
  void notify() {
    print("Notificación: Item guardado");
  }
}

class SaveTask extends SaveItemTemplate {
  @override
  void validate() => print("Validando Task...");

  @override
  void persist() => print("Guardando Task en DB...");
}

class SaveNote extends SaveItemTemplate {
  @override
  void validate() => print("Validando Note...");

  @override
  void persist() => print("Guardando Note en DB...");
}
