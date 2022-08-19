import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:facebook/constants/constants.dart';
import 'package:facebook/model/user/activate_response/activate_response.dart';
import 'package:facebook/model/user/user_response.dart';
import 'package:facebook/services/remote_service.dart';
import 'package:facebook/utils/handle_api_error.dart';

class UserService {
  static const userEndPoint = "/users";

  static activate(String firstName, String lastName, String password) async {
    final body = {
      "firstName": firstName,
      "lastName": lastName,
      "password": password
    };

    try {
      const url = "$userEndPoint/activate";
      final response =
          await RemoteService.dio().put(url, data: jsonEncode(body));
      return ActivateResponse.fromJson(response.data);
    } catch (e) {
      return handleApiError(e);
    }
  }

  static me() async {
    try {
      const url = "${Constants.apiBaseURL}$userEndPoint/me";
      final response = await RemoteService.dio().get(url);
      return UserResponse.fromJson(response.data);
    } catch (e) {
      return handleApiError(e);
    }
  }

  static uploadAsAvatar(File file) async {
    try {
      const url = "$userEndPoint/update-avatar";
      final formDataFile =
          dio.MultipartFile.fromBytes(await file.readAsBytes());
      final formData = dio.FormData.fromMap({"file": formDataFile});
      final response = await RemoteService.dio().post(url, data: formData);
      print("File uploaded successfully! ${response.data} ✅✅✅");
      return response.data;
    } catch (e) {
      return handleApiError(e);
    }
  }

  static uploadAsCover(File file) async {
    try {
      const url = "$userEndPoint/update-cover";
      final formDataFile =
          dio.MultipartFile.fromBytes(await file.readAsBytes());
      final formData = dio.FormData.fromMap({"file": formDataFile});
      final response = await RemoteService.dio().post(url, data: formData);
      print("File uploaded successfully! ${response.data} ✅✅✅");
      return response.data;
    } catch (e) {
      return handleApiError(e);
    }
  }
}
