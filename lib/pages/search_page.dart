import 'package:facebook/controllers/users/search_controller.dart';
import 'package:facebook/routes/navigation_routes.dart';
import 'package:facebook/theme/my_theme.dart';
import 'package:facebook/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Expanded(
        child: Column(
          children: [
            const _SearchBar(),
            Obx(() {
              if (_searchController.fetching) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (_searchController.searchUserResponse.isEmpty) {
                return const Center(
                  child: Expanded(
                    child: Text(
                      "No users found!",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemBuilder: (context, index) {
                  final user = _searchController.searchUserResponse[index];
                  return InkWell(
                    onTap: () {
                      // redirect to profile page
                      Get.toNamed(NavigationRouter.profileRoute,
                          arguments: {"id": user.id!});
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          if (user.avatar == null ||
                              user.avatar.toString().isEmpty)
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Theme.of(context).cardColor,
                              child: const Icon(
                                FontAwesomeIcons.solidUser,
                                color: Colors.grey,
                              ),
                            )
                          else
                            ProfileAvatar(imageURL: user.avatar!),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${user.firstName} ${user.lastName}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "view profile",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[500]),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
                itemCount: _searchController.searchUserResponse.length,
              );
            })
          ],
        ),
      ),
    ));
  }
}

class _SearchBar extends StatefulWidget {
  const _SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _searchController = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Form(
              child: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  icon: const Icon(
                    FontAwesomeIcons.arrowLeft,
                    size: 20,
                  ))),
          const SizedBox(
            width: 16,
          ),
          Expanded(
              child: Form(
            child: TextFormField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  hintText: "Search",
                  prefixIcon: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 20,
                    color: MyTheme.iconColor,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0))),
              onEditingComplete: () async {
                await Future.delayed(const Duration(milliseconds: 250));
                await _searchController.search();
              },
              onChanged: (value) {
                _searchController.query = value;
              },
              keyboardType: TextInputType.text,
            ),
          ))
        ],
      ),
    );
  }
}
