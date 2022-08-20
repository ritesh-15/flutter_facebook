import 'package:dio/dio.dart';
import 'package:facebook/model/api_error_response.dart';
import 'package:facebook/model/auth/refresh_response/refresh_response.dart';
import 'package:facebook/services/auth/auth_service.dart';
import 'package:facebook/services/remote_service.dart';
import 'package:facebook/services/token_service.dart';

class RetryInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      final response = await AuthService.refresh();

      if (response is ApiErrorResponse) {
        await TokenService.clearTokens();
        return handler.reject(err);
      }

      if (response is RefreshResponse) {
        await TokenService.storeTokens(
            response.accessToken!, response.refreshToken!);
        return handler.resolve(await _retry(err.requestOptions));
      }
    }

    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }

  Future<Response<dynamic>> _retry(RequestOptions request) async {
    final options = Options(method: request.method, headers: request.headers);

    return RemoteService.dio().request(request.path,
        options: options,
        data: request.data,
        queryParameters: request.queryParameters);
  }

  bool _shouldRetry(DioError error) {
    return error.response != null && error.response!.statusCode == 401;
  }
}
