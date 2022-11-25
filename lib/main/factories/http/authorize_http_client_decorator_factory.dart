import 'package:flutter_bloc_login/main/decorators/authorize_http_client_decorator.dart';
import 'package:flutter_bloc_login/main/factories/http/http.dart';
import 'package:http_client_adapter/http_client.dart';

HttpClient makeAuthorizeHttpClientDecorator() => AuthorizeHttpClientDecorator(decorate: makeHttpAdapterFactory());
