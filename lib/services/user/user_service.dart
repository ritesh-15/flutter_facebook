import 'dart:convert';

import 'package:facebook/constants/constants.dart';
import 'package:facebook/model/api_error_response.dart';
import 'package:facebook/model/user/activate_response/activate_response.dart';
import 'package:facebook/services/remote_service.dart';

class UserService {
  static const authEndPoint = "/users";

  static activate(String firstName, String lastName, String password) async {
    final body = {
      "firstName": firstName,
      "lastName": lastName,
      "password": password
    };

    try {
      const url = "${Constants.apiBaseURL}$authEndPoint/activate";

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
}
