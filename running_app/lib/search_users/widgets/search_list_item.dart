import 'package:core/di/app_blocs.dart';
import 'package:domain/entities/search_user_entity.dart';
import 'package:flutter/material.dart';
import 'package:running_app/search_users/search_users_view_event.dart';
import 'package:running_app/user_profile/widgets/friend_status_button.dart';

class UserListItem extends StatefulWidget {
  final SearchUserEntity user;
  final VoidCallback onTap;
  const UserListItem({super.key, required this.user, required this.onTap});

  @override
  State<UserListItem> createState() => _UserListItemState();
}

class _UserListItemState extends State<UserListItem> {
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
                onTap: widget.onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: MemoryImage(widget.user.imageData),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.user.name,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                "${widget.user.commonFriends.toString()} common friend${widget.user.commonFriends > 1 ? "s" : ""}",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                "${widget.user.city}, ${widget.user.country}",
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
              FriendshipButton(
                status: widget.user.friendshipStatus,
                onAddFriend: () {
                  AppBlocs.searchUsersBloc.add(AddFriendEvent(widget.user.id));
                  setState(() {
                    widget.user.friendshipStatus = FriendshipStatus.pending;
                  });
                },
                onAcceptRequest: () {
                  // TODO: Search for the existing friend request in order to accept it

                  // AppBlocs.friendships.add(AcceptFriendshipRequestEvent(request: widget.friendRequest!));
                  // setState(() {
                  //   widget.user.friendshipStatus = FriendshipStatus.friends;
                  // });
                },
                onCancelRequest: () {
                  setState(() {
                    widget.user.friendshipStatus = FriendshipStatus.none;
                  });
                },
                onRemoveFriend: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
