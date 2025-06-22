import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class TeardropIcon extends StatelessWidget {
  final bool isMirrored;
  final IconData icon;

  const TeardropIcon({super.key, this.isMirrored = false, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 30,
      child: Stack(
        children: [
          Transform.flip(
              flipX: isMirrored,
              child: SvgPicture.asset(
                'assets/images/tear_drop_icon.svg',
                width: 40,
                height: 40,
                color: Theme.of(context).colorScheme.onSurface,
              )),
          Center(
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.surface,
              size: 15,
            ),
          )
        ],
      ),
    );
  }
}
