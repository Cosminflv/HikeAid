import 'package:flutter/material.dart';
import 'package:running_app/config/theme.dart';
import 'package:running_app/search_users/widgets/search_list_item.dart';

class SearchListView extends StatelessWidget {
  const SearchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getAppbarColor(context),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7, // Set desired height
        child: Scrollbar(
          interactive: true,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserListItem(),
              UserListItem(),
              UserListItem(),
              UserListItem(),
              UserListItem(),
              UserListItem(),
              UserListItem(),
              UserListItem(),
              UserListItem(),
              UserListItem(),
              UserListItem(),
              UserListItem(),
            ],
          ),
        ),
      ),
    );
  }
}
