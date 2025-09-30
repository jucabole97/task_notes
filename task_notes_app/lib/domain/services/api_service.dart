abstract class ApiService {
  Future<dynamic> get(String endpoint, {bool isList = false});
  Future<dynamic> getById(String resource, String id);
  Future<dynamic> post(String endpoint, Map<String, dynamic> body);
  Future<dynamic> put(String endpoint, Map<String, dynamic> body);
  Future<dynamic> delete(String endpoint);
}
