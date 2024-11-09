import 'package:domain/entities/search_user_entity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/onboarding/auth_session/auth_session_state.dart';
import 'package:running_app/providers/bloc_providers.dart';
import 'package:running_app/search_users/search_users_view_event.dart';
import 'package:running_app/shared_widgets/custom_text_button.dart';

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
    final searchUsersBloc = BlocProviders.searchUsers(context);
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
              SizedBox(
                width: 70,
                height: 40,
                child: Builder(builder: (context) {
                  if (widget.user.friendshipStatus == FriendshipStatus.none) {
                    return CustomElevatedButton(
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                      text: "Add",
                      onTap: () {
                        final currUserId =
                            (BlocProviders.authSession(context).state as AuthSessionExistingState).session.user.id;
                        searchUsersBloc.add(AddFriendEvent(requesterId: currUserId, receiverId: widget.user.id));
                        setState(() {
                          widget.user.friendshipStatus = FriendshipStatus.pending;
                        });
                      },
                    );
                  }
                  if (widget.user.friendshipStatus == FriendshipStatus.friends) {
                    return CustomElevatedButton(
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                      leading: const Icon(FontAwesomeIcons.check),
                    );
                  }
                  if (widget.user.friendshipStatus == FriendshipStatus.pending) {
                    return CustomElevatedButton(
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                      text: "Pending",
                    );
                  }
                  return const SizedBox.shrink();
                }),
              )
            ],
          ),
        ],
      ),
    );
  }
}
