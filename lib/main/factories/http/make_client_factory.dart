import 'package:http/http.dart';
import 'package:http_client_adapter/http_client.dart';

HttpClient makeHttpAdapterFactory() => HttpClientAdapter(Client());
