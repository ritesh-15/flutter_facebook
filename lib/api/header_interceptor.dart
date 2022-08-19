import 'package:dio/dio.dart';
import 'package:facebook/constants/constants.dart';
import 'package:facebook/services/token_service.dart';

class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final tokens = await TokenService.getTokens();

    options.headers["refreshtoken"] =
        "Bearer ${tokens[Constants.refreshToken]}";

    options.headers["authorization"] =
        "Bearer ${tokens[Constants.accessToken]}";

    options.headers["Content-Type"] = "application/json";

    super.onRequest(options, handler);
  }
}
