import 'package:facebook/api/header_interceptor.dart';
import 'package:facebook/api/refresh_retry_policy.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

class RemoteService {
  static final http.Client _client = InterceptedClient.build(
      interceptors: [HeaderInterceptor()], retryPolicy: RefreshRetryPolicy());

  static http.Client get client => _client;
}
