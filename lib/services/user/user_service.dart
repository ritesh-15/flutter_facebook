import 'dart:convert';

import 'package:facebook/constants/constants.dart';
import 'package:facebook/model/api_error_response.dart';
import 'package:facebook/model/user/activate_response/activate_response.dart';
import 'package:facebook/model/user/me_response.dart';
import 'package:facebook/services/remote_service.dart';

class UserService {
  static const userEndPoint = "/users";

  static activate(String firstName, String lastName, String password) async {
    final body = {
      "firstName": firstName,
      "lastName": lastName,
      "password": password
    };

    try {
      const url = "${Constants.apiBaseURL}$userEndPoint/activate";

      final response = await RemoteService.client
          .put(Uri.parse(url), body: jsonEncode(body));

      if (response.statusCode == 200) {
        return ActivateResponse.fromJson(response.body);
      }

      return ApiErrorResponse.fromJson(response.body).message;
    } catch (e) {
      return "Cannot reach to server at this time, please check your internet connection!";
    }
  }

  static me() async {
    try {
      const url = "${Constants.apiBaseURL}$userEndPoint/me";

      final response = await RemoteService.client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return MeResponse.fromJson(response.body);
      }

      return ApiErrorResponse.fromJson(response.body).message;
    } catch (e) {
      return "Cannot reach to server at this time, please check your internet connection!";
    }
  }
}
