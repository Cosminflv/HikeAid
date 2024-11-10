import 'package:domain/entities/search_user_entity.dart';
import 'package:flutter/material.dart';
import 'package:running_app/config/theme.dart';
import 'package:running_app/search_users/widgets/search_list_item.dart';

class SearchListView extends StatelessWidget {
  final List<SearchUserEntity> users;
  final Function(SearchUserEntity) onItemTap;
  const SearchListView({super.key, required this.users, required this.onItemTap});

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
              children: List.generate(
                  users.length,
                  (index) => UserListItem(
                        user: users[index],
                        onTap: () => onItemTap(users[index]),
                      ))),
        ),
      ),
    );
  }
}
