import 'dart:io';

import 'package:dio/dio.dart';
import 'package:facebook/model/api_error_response.dart';

handleApiError(dynamic error) {
  if (error is DioError) {
    return ApiErrorResponse.fromMap(error.response?.data).message;
  }

  if (error is SocketException) {
    return "Couldn't reach to the server please check you internet connection!";
  }

  return "Something went wrong!";
}
