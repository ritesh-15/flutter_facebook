import 'dart:convert';

import 'package:facebook/constants/constants.dart';
import 'package:facebook/model/api_error_response.dart';
import 'package:facebook/model/auth/forgot-password/forgot_password_response.dart';
import 'package:facebook/model/auth/login_request.dart';
import 'package:facebook/model/auth/login_response/login_response.dart';
import 'package:facebook/model/auth/otp_response/otp_response.dart';
import 'package:facebook/model/auth/refresh_response/refresh_response.dart';
import 'package:facebook/model/auth/verify_response/verify_response.dart';
import 'package:facebook/services/remote_service.dart';

class AuthService {
  static const authEndPoint = "/auth";

  static login(LoginRequest body) async {
    try {
      const url = "${Constants.apiBaseURL}$authEndPoint/signin";

      final response =
          await RemoteService.client.post(Uri.parse(url), body: body.toJson());

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.body);
      }

      return ApiErrorResponse.fromJson(response.body);
    } catch (e) {
      return "Cannot reach to server at this time, please check your internet connection!";
    }
  }

  static register(String email) async {
    final body = {"email": email};

    try {
      const url = "${Constants.apiBaseURL}$authEndPoint/signup";

      final response = await RemoteService.client
          .post(Uri.parse(url), body: jsonEncode(body));

      if (response.statusCode == 201) {
        return OtpResponse.fromJson(response.body);
      }

      return ApiErrorResponse.fromJson(response.body).message;
    } catch (e) {
      return "Cannot reach to server at this time, please check your internet connection!";
    }
  }

  static verify(String email, String hash, String code) async {
    final body = {"email": email, "hash": hash, "code": code};

    try {
      const url = "${Constants.apiBaseURL}$authEndPoint/verifyOtp";

      final response = await RemoteService.client
          .post(Uri.parse(url), body: jsonEncode(body));

      if (response.statusCode == 200) {
        return VerifyOtpResponse.fromJson(response.body);
      }

      return ApiErrorResponse.fromJson(response.body).message;
    } catch (e) {
      return "Cannot reach to server at this time, please check your internet connection!";
    }
  }

  static resend(String email) async {
    final body = {"email": email};

    try {
      const url = "${Constants.apiBaseURL}$authEndPoint/resendOtp";

      final response = await RemoteService.client
          .post(Uri.parse(url), body: jsonEncode(body));

      if (response.statusCode == 200) {
        return OtpResponse.fromJson(response.body);
      }

      return ApiErrorResponse.fromJson(response.body).message;
    } catch (e) {
      return "Cannot reach to server at this time, please check your internet connection!";
    }
  }

  static refresh() async {
    try {
      const url = "${Constants.apiBaseURL}$authEndPoint/refresh";

      final response = await RemoteService.client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return RefreshResponse.fromJson(response.body);
      }

      return ApiErrorResponse.fromJson(response.body).message;
    } catch (e) {
      return "Cannot reach to server at this time, please check your internet connection!";
    }
  }

  static forgotPassword(String email) async {
    final body = {"email": email};

    try {
      const url = "${Constants.apiBaseURL}$authEndPoint/forgot-password";

      final response = await RemoteService.client
          .post(Uri.parse(url), body: jsonEncode(body));

      if (response.statusCode == 200) {
        return ForgotPasswordResponse.fromJson(response.body);
      }

      return ApiErrorResponse.fromJson(response.body).message;
    } catch (e) {
      return "Cannot reach to server at this time, please check your internet connection!";
    }
  }
}
