class FCMService {
  static final FCMService _instance = FCMService._internal();

  String? _token;

  factory FCMService() => _instance;

  FCMService._internal();

  void setToken(String token) => _token = token;

  String? get token => _token;
}
