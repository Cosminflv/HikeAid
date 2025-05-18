import 'package:flutter/material.dart';

class ViewHikeButton extends StatelessWidget {
  final VoidCallback onPressed;
  const ViewHikeButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(
        Icons.hiking,
        color: Colors.white,
        size: 20,
      ),
      label: Text(
        "View Hike",
        style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
