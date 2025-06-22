import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class NamedCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget content;
  final VoidCallback? onDetailsTap;
  final bool isInteractive;

  const NamedCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.content,
    required this.isInteractive,
    this.onDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0, top: 16.0, left: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!isInteractive)
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                if (subtitle != null && isInteractive)
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                if (!isInteractive && onDetailsTap != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: PlatformTextButton(
                      onPressed: onDetailsTap,
                      child: const Text("Details"),
                    ),
                  )
              ],
            ),
          ),
          content
        ],
      ),
    );
  }
}
