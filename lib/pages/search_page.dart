import 'package:dio/dio.dart';
import 'package:facebook/controllers/users/search_controller.dart';
import 'package:facebook/theme/my_theme.dart';
import 'package:facebook/widgets/input.widget.dart';
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
      child: Column(
        children: [
          const _SearchBar(),
          Obx(() {
            if (_searchController.fetching) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemBuilder: (context, index) {
                final user = _searchController.searchUserResponse[index];
                return Row(
                  children: [
                    if (user.avatar == null || user.avatar.toString().isEmpty)
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
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[500]),
                        )
                      ],
                    )
                  ],
                );
              },
              shrinkWrap: true,
              itemCount: _searchController.searchUserResponse.length,
            );
          })
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                suffixIcon: const Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 20,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
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
