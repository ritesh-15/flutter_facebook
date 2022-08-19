import 'package:dio/dio.dart';
import 'package:facebook/api/header_interceptor.dart';
import 'package:facebook/api/retry_interceptoros.dart';
import 'package:facebook/constants/constants.dart';

class RemoteService {
  static final Dio _dio = Dio(BaseOptions(baseUrl: Constants.apiBaseURL));

  static Dio dio() {
    _dio.interceptors.addAll([HeaderInterceptor(), RetryInterceptor()]);
    return _dio;
  }
}
