import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapUpdateAvailableCard extends StatelessWidget {
  const MapUpdateAvailableCard({
    super.key,
    required this.newVersion,
    required this.onUpdateButtonTap,
    required this.onDismiss,
  });

  final String newVersion;
  final VoidCallback onUpdateButtonTap;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 250,
          child: Stack(
            children: [
              Positioned(
                right: 10,
                top: 10,
                child: IconButton(
                  onPressed: onDismiss,
                  icon: Icon(
                    CupertinoIcons.xmark_circle_fill,
                    size: 32,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Icon(
                      CupertinoIcons.cloud_download,
                      size: 45,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    const SizedBox(height: 20),
                    Text("Map update available", style: Theme.of(context).textTheme.titleLarge),
                    Text("Map Version: $newVersion", style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: onUpdateButtonTap,
                      child: Text("Update Now",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
