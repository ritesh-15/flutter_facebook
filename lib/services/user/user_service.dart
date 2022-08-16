import 'dart:convert';
import 'dart:io';

import 'package:facebook/constants/constants.dart';
import 'package:facebook/model/api_error_response.dart';
import 'package:facebook/model/user/activate_response/activate_response.dart';
import 'package:facebook/model/user/user_response.dart';
import 'package:facebook/services/remote_service.dart';
import 'package:facebook/services/token_service.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

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
        return UserResponse.fromJson(response.body);
      }

      return ApiErrorResponse.fromJson(response.body).message;
    } catch (e) {
      return "Cannot reach to server at this time, please check your internet connection!";
    }
  }

  static uploadAsAvatar(File file) async {
    try {
      const url = "${Constants.apiBaseURL}$userEndPoint/update-avatar";

      final response = await RemoteService.client.post(Uri.parse(url),
          headers: <String, String>{"Content-type": "multipart/form-data"},
          body: {"file": file});

      if (response.statusCode == 200) {
        return UserResponse.fromJson(response.body);
      }

      return ApiErrorResponse.fromJson(response.body).message;
    } catch (e) {
      return "Cannot reach to server at this time, please check your internet connection!";
    }
  }

  static uploadAsCover(File file) async {
    try {
      print("File path is ${file.absolute} 👇👇👇");

      const url = "${Constants.apiBaseURL}$userEndPoint/update-cover";

      var request = http.MultipartRequest("POST", Uri.parse(url));

      final token = await TokenService.getTokens();

      if (token == null) throw Error();

      request.headers.addAll({
        "Content-Type": "multipart/form-data",
        "Authorization": "Bearer ${token[Constants.accessToken]}"
      });

      final bytes = await file.readAsBytes();

      final httpImage = await http.MultipartFile.fromBytes("file", bytes,
          filename: path.basename(file.path));

      request.files.add(httpImage);

      final response = await http.Response.fromStream(await request.send());

      print("File upload response ${response.body.toString()}");

      return "Hey i think uploaded!";
      // return ApiErrorResponse.fromJson(response.body).message;
    } catch (e) {
      print("${e.toString()} ❌❌❌");
      return "Cannot reach to server at this time, please check your internet connection!";
    }
  }
}
