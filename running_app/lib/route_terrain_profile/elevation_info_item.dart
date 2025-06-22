import 'package:flutter/material.dart';

import '../config/theme.dart';

class ElevationInfoItem extends StatelessWidget {
  final Widget icon;
  final String value;
  final VoidCallback onTap;

  const ElevationInfoItem({super.key, required this.icon, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: getThemedItemBackgroundColor(context),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                  ),
                ],
              ),
              width: 60,
              height: 60,
              child: icon,
            ),
          ),
          Text(value, style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }
}
