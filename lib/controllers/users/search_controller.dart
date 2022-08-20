import 'package:dio/dio.dart';
import 'package:facebook/model/user/search_users_response/search_user.dart';
import 'package:facebook/model/user/search_users_response/search_users_response.dart';
import 'package:facebook/services/user/user_service.dart';
import 'package:facebook/utils/snackbar_helper.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  // query state
  final RxString _query = "".obs;
  String get query => _query.value;
  set query(value) => _query.value = value;

  // users
  final Rx<SearchUsersResponse> _searchUserResponse = SearchUsersResponse().obs;
  List<SearchUser> get searchUserResponse =>
      _searchUserResponse.value.users ?? [];
  set searchUserResponse(value) => _searchUserResponse.value = value;

  // fetching state
  final RxBool _fetching = false.obs;
  bool get fetching => _fetching.value;
  set fetching(value) => _fetching.value = value;

  static CancelToken cancelToken = CancelToken();

  Future<void> search() async {
    fetching = true;
    final response = await UserService.search(query, cancelToken);
    fetching = false;

    if (response is SearchUsersResponse) {
      searchUserResponse = response;
      print("Search user response ✅✅");
      print(response.users.toString());
      return;
    }

    if (response.toString().isNotEmpty) {
      SnackbarHelper.showSnackBar("Oops!", response);
    }
  }
}
