class ItemSingleton {
  static final ItemSingleton _instance = ItemSingleton._internal();

  factory ItemSingleton() {
    return _instance;
  }

  ItemSingleton._internal();

  String apiBaseUrl = "https://api.example.com";
  String appTheme = "light";
}
