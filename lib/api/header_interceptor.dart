import 'package:facebook/constants/constants.dart';
import 'package:facebook/services/token_service.dart';
import 'package:http_interceptor/http_interceptor.dart';

class HeaderInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      final tokens = await TokenService.getTokens();
      data.headers["refreshtoken"] = "Bearer ${tokens[Constants.refreshToken]}";
      data.headers["authorization"] = "Bearer ${tokens[Constants.accessToken]}";
      data.headers["Content-Type"] = "application/json";
    } catch (e) {}
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async =>
      data;
}
