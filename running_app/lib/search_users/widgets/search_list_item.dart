import 'package:domain/entities/search_user_entity.dart';
import 'package:flutter/material.dart';
import 'package:running_app/shared_widgets/custom_text_button.dart';

class UserListItem extends StatelessWidget {
  final SearchUserEntity user;
  final VoidCallback onTap;
  const UserListItem({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Theme.of(context).colorScheme.outlineVariant,
                onTap: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: MemoryImage(user.imageData),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                "${user.commonFriends.toString()} common friend${user.commonFriends > 1 ? "s" : ""}",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                "${user.city}, ${user.country}",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 70,
                height: 40,
                child: CustomElevatedButton(
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  text: "Add",
                  onTap: () {
                    //TODO: Add user as a friend
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
