import 'package:core/di/app_blocs.dart';
import 'package:domain/entities/friendship_entity.dart';
import 'package:domain/entities/search_user_entity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/config/routes.dart';
import 'package:running_app/friendships/friendships_view_events.dart';
import 'package:running_app/user_profile/user_profile_view_event.dart';

// ignore: must_be_immutable
class FriendshipRequestsList extends StatefulWidget {
  List<FriendshipEntity> requests;
  FriendshipRequestsList({required this.requests, super.key});

  @override
  State<FriendshipRequestsList> createState() => _FriendshipRequestsListState();
}

class _FriendshipRequestsListState extends State<FriendshipRequestsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.requests.length,
      itemBuilder: (context, index) {
        final request = widget.requests[index];
        return InkWell(
          onTap: () {
            AppBlocs.userProfileBloc.add(FetchUserProfileEvent(userId: request.requesterId));
            Navigator.of(context).pushNamed(
              RouteNames.userProfilePage,
              arguments: {
                'isEditable': false,
                'friendshipStatus': FriendshipStatus.waitingAccept,
                'friendRequest': request
              },
            );
          },
          child: Card(
            color: Theme.of(context).colorScheme.surface,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(request.requesterName[0]), // Initial of requester name
              ),
              title: Text(request.requesterName),
              trailing: Row(
                mainAxisSize: MainAxisSize.min, // This ensures buttons are side by side
                children: [
                  IconButton(
                    icon: const Icon(FontAwesomeIcons.check),
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      _acceptRequest(request);
                    },
                  ),
                  IconButton(
                    icon: const Icon(FontAwesomeIcons.xmark),
                    color: Colors.red,
                    onPressed: () {
                      _declineRequest(request);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _acceptRequest(FriendshipEntity request) {
    // Example: Show a SnackBar to confirm action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Accepted request from ${request.requesterName}')),
    );

    // Remove the accepted request from the list
    setState(() {
      AppBlocs.friendships.add(AcceptFriendshipRequestEvent(request: request));
      widget.requests.remove(request);
    });
  }

  void _declineRequest(FriendshipEntity request) {
    // Example: Show a SnackBar to confirm action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Declined request from ${request.requesterName}')),
    );

    // Remove the accepted request from the list
    setState(() {
      AppBlocs.friendships.add(DeclineFriendshipRequestEvent(request: request));
      widget.requests.remove(request);
    });
  }
}
