abstract class GetService {
  Future<dynamic> get(String endpoint, {bool isList = false});
}

abstract class GetByIdService {
  Future<dynamic> getById(String resource, String id);
}

abstract class PostService {
  Future<dynamic> post(String endpoint, Map<String, dynamic> body);
}

abstract class PutService {
  Future<dynamic> put(String endpoint, Map<String, dynamic> body);
}

abstract class DeleteService {
  Future<dynamic> delete(String endpoint);
}
