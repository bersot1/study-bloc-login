import 'dart:convert';

import 'package:http/http.dart';

import 'enums/enums.dart';

abstract class HttpClient {
  Future<dynamic> request({
    required String url,
    required HttpMethods method,
    Map? body,
    Map? headers,
  });
}

class HttpClientAdapter implements HttpClient {
  const HttpClientAdapter(this.client);

  final Client client;

  @override
  Future request({
    required String url,
    required HttpMethods method,
    Map? body,
    Map? headers,
  }) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({'content-type': 'aplication/json', 'accept': 'application/json'});

    final jsonBody = body != null ? jsonEncode(body) : null;
    var response = Response('', 500);

    late Future<Response>? futureResponse;

    try {
      if (method == HttpMethods.post) {
        futureResponse = client.post(Uri.parse(url), headers: defaultHeaders, body: jsonBody);
      } else if (method == HttpMethods.get) {
        futureResponse = client.get(Uri.parse(url), headers: defaultHeaders);
      } else if (method == HttpMethods.del) {
        futureResponse = client.delete(Uri.parse(url), headers: defaultHeaders);
      }

      if (futureResponse != null) {
        response = await futureResponse.timeout(const Duration(seconds: 10));
      }
    } catch (e) {
      throw HttpError.serverError;
    }

    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.body.isEmpty ? null : response.body;
      case 204:
        return null;
      case 400:
        throw HttpError.badRequest;
      case 401:
        throw HttpError.unauthorized;
      case 403:
        throw HttpError.forbidden;
      case 404:
        throw HttpError.notFound;
      default:
        throw HttpError.serverError;
    }
  }
}
