import 'dart:convert';
import 'dart:io';

import '../../core/core.dart';

class ApiService {
  final _client = HttpClient();
  final String baseUrl = ApiConfig.baseUrl;

  /// GET
  Future<dynamic> get(String endpoint, {bool isList = false}) async {
    final uri = Uri.parse('http://192.168.1.14:3000/$endpoint');

    final request = await _client.getUrl(uri);

    final response = await request.close();

    return _handleResponse(response, uri, isList: isList);
  }

  /// GET BY ID
  Future<dynamic> getById(String resource, String id) async {
    final uri = Uri.parse('http://192.168.1.14:3000/$resource/$id');

    final response = await get('$resource/$id');

    return _handleResponse(response, uri);
  }

  /// POST
  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('http://192.168.1.14:3000/$endpoint');

    final request = await _client.postUrl(uri);

    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(body));

    final response = await request.close();

    return _handleResponse(response, uri);
  }

  /// PUT
  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('$baseUrl$endpoint');

    final request = await _client.putUrl(uri);

    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(body));

    final response = await request.close();

    return _handleResponse(response, uri);
  }

  /// DELETE
  Future<dynamic> delete(String endpoint) async {
    final uri = Uri.parse('$baseUrl$endpoint');

    final request = await _client.deleteUrl(uri);
    final response = await request.close();

    return _handleResponse(response, uri);
  }

  /// RESPONSE
  Future<dynamic> _handleResponse(
    HttpClientResponse response,
    Uri uri, {
    bool isList = false,
  }) async {
    final body = await response.transform(utf8.decoder).join();
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (body.isEmpty) {
        return isList ? <Map<String, dynamic>>[] : <String, dynamic>{};
      }

      final decoded = jsonDecode(body);
      if (decoded is List) {
        return decoded.map((e) => e as Map<String, dynamic>).toList();
      }

      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      throw FormatException(
        'Respuesta no es un Map<String, dynamic> o List<Map<String, dynamic>>: $decoded',
      );
    }

    throw HttpException(
      'Error [${response.statusCode}] en $uri\nBody: $body',
      uri: uri,
    );
  }
}
