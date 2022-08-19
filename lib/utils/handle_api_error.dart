import 'package:dio/dio.dart';

handleApiError(dynamic error) {
  if (error is DioError) {
    return error.response?.data.message;
  }

  return "Couldn't reach to the server please check you internet connection!";
}
