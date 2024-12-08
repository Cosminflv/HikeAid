import 'package:core/di/app_blocs.dart';
import 'package:domain/entities/friendship_entity.dart';
import 'package:flutter/material.dart';
import 'package:running_app/friendships/friendships_view_events.dart';

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
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(request.requesterName[0]), // Initial of requester name
            ),
            title: Text(request.requesterName),
            subtitle: Text('ID: ${request.requesterId}'),
            trailing: ElevatedButton(
              onPressed: () {
                _acceptRequest(request);
              },
              child: const Text('Accept'),
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
}
