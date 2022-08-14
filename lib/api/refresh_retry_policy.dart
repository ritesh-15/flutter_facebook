import 'package:facebook/model/auth/refresh_response/refresh_response.dart';
import 'package:facebook/services/auth/auth_service.dart';
import 'package:facebook/services/token_service.dart';
import 'package:http_interceptor/http_interceptor.dart';

class RefreshRetryPolicy extends RetryPolicy {
  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    if (response.statusCode == 401) {
      final response = await AuthService.refresh();

      if (response is RefreshResponse) {
        await TokenService.storeTokens(
            response.accessToken!, response.refreshToken!);

        return true;
      }

      await TokenService.clearTokens();

      return false;
    }

    return false;
  }

  @override
  int get maxRetryAttempts => 1;
}
