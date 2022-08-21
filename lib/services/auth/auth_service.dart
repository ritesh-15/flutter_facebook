import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:facebook/model/api_error_response.dart';
import 'package:facebook/model/auth/forgot-password/forgot_password_response.dart';
import 'package:facebook/model/auth/login_request.dart';
import 'package:facebook/model/auth/login_response/login_response.dart';
import 'package:facebook/model/auth/otp_response/otp_response.dart';
import 'package:facebook/model/auth/refresh_response/refresh_response.dart';
import 'package:facebook/model/auth/verify_response/verify_response.dart';
import 'package:facebook/model/logout_response.dart';
import 'package:facebook/services/remote_service.dart';
import 'package:facebook/utils/handle_api_error.dart';

class AuthService {
  static const authEndPoint = "/auth";

  static login(LoginRequest body) async {
    try {
      const url = "$authEndPoint/signin";
      final response = await RemoteService.dio().post(url, data: body.toJson());
      return LoginResponse.fromMap(response.data);
    } catch (e) {
      if (e is DioError) {
        return ApiErrorResponse.fromMap(e.response?.data);
      }
      return handleApiError(e);
    }
  }

  static register(String email) async {
    final body = {"email": email};

    try {
      const url = "$authEndPoint/signup";
      final response =
          await RemoteService.dio().post(url, data: jsonEncode(body));
      return OtpResponse.fromMap(response.data);
    } catch (e) {
      return handleApiError(e);
    }
  }

  static verify(String email, String hash, String code) async {
    final body = {"email": email, "hash": hash, "code": code};

    try {
      const url = "$authEndPoint/verifyOtp";
      final response =
          await RemoteService.dio().post(url, data: jsonEncode(body));
      return VerifyOtpResponse.fromMap(response.data);
    } catch (e) {
      return handleApiError(e);
    }
  }

  static resend(String email) async {
    final body = {"email": email};

    try {
      const url = "$authEndPoint/resendOtp";
      final response =
          await RemoteService.dio().post(url, data: jsonEncode(body));
      return OtpResponse.fromMap(response.data);
    } catch (e) {
      return handleApiError(e);
    }
  }

  static refresh() async {
    try {
      const url = "$authEndPoint/refresh";
      final response = await RemoteService.dio().get(url);
      return RefreshResponse.fromMap(response.data);
    } catch (e) {
      if (e is DioError) {
        return ApiErrorResponse.fromMap(e.response?.data);
      }
      return handleApiError(e);
    }
  }

  static forgotPassword(String email) async {
    final body = {"email": email};

    try {
      const url = "$authEndPoint/forgot-password";
      final response =
          await RemoteService.dio().post(url, data: jsonEncode(body));
      return ForgotPasswordResponse.fromMap(response.data);
    } catch (e) {
      return handleApiError(e);
    }
  }

  static logout() async {
    try {
      const url = "$authEndPoint/logout";
      final response = await RemoteService.dio().delete(url);
      return LogoutResponse.fromMap(response.data);
    } catch (e) {
      return handleApiError(e);
    }
  }
}
