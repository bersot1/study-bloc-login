import 'package:http_client_adapter/http_client.dart';

class AuthorizeHttpClientDecorator implements HttpClient {
  // final GetSecureCacheStorage getSecureCacheStorage;
  // final DeleteSecureCacheStorage deleteSecureCacheStorage;
  final HttpClient decorate;

  AuthorizeHttpClientDecorator({
    // required this.getSecureCacheStorage,
    // required this.deleteSecureCacheStorage,
    required this.decorate,
  });

  @override
  Future request({
    required String url,
    required HttpMethods method,
    Map? body,
    Map? headers,
  }) async {
    try {
      // final token = await getSecureCacheStorage.get('token');
      final authorizedHeaders = headers ?? {}
        ..addAll({'Authorization': 'Bearer token'});
      return await decorate.request(url: url, method: method, body: body, headers: authorizedHeaders);
    } catch (error) {
      if (error is HttpError && error != HttpError.forbidden) {
        rethrow;
      } else {
        // await deleteSecureCacheStorage.delete('token');
        throw HttpError.forbidden;
      }
    }
  }
}
