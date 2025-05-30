import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const RouteActionButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 0.2,
            ),
            borderRadius: BorderRadius.circular(8),
          )),
      onPressed: onTap,
      child: IntrinsicWidth(
        child: Row(
          children: [
            Icon(
              CupertinoIcons.location_north_fill,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 20,
            ),
            const SizedBox(width: 5),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
