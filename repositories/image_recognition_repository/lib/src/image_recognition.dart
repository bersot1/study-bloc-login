import 'dart:convert';

import 'package:http_client_adapter/http_client.dart';

class ImageRecognitionRepository {
  ImageRecognitionRepository({
    required this.httpClient,
    required this.url,
  });

  final HttpClient httpClient;
  final String url;

  Future<String> getTextFromImage(String imageB64) async {
    try {
      final httpResponse = await httpClient.request(url: '$url', method: HttpMethods.get);
      final decodedResponse = jsonDecode(httpResponse);

      return decodedResponse['response'];
    } on HttpError {
      rethrow;
    }
  }
}
