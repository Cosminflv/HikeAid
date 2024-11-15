import 'package:domain/entities/search_user_entity.dart';
import 'package:flutter/material.dart';

class FriendshipButton extends StatelessWidget {
  final FriendshipStatus status;
  final VoidCallback onAddFriend;
  final VoidCallback onRemoveFriend;
  final VoidCallback onCancelRequest;

  const FriendshipButton({
    super.key,
    required this.status,
    required this.onAddFriend,
    required this.onRemoveFriend,
    required this.onCancelRequest,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon;
    String label;
    VoidCallback onPressed;

    // Set the icon, label, and onPressed action based on the status
    switch (status) {
      case FriendshipStatus.none:
        icon = Icons.person_add;
        label = 'Add';
        onPressed = onAddFriend;

        break;

      case FriendshipStatus.friends:
        icon = Icons.check;
        label = 'Friends';
        onPressed = onRemoveFriend;

        break;

      case FriendshipStatus.pending:
        icon = Icons.cancel;
        label = 'Sent';
        onPressed = onCancelRequest;

        break;
    }

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
      label: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
