import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/config/theme.dart';

class SignalAlertButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SignalAlertButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Durations.short1,
      bottom: 10.0,
      left: 10,
      child: Container(
        height: 50,
        width: 40,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: getAppbarColor(context),
        ),
        child: Column(
          children: [
            Expanded(
                child: IconButton(
                    splashColor: transparentColor,
                    highlightColor: transparentColor,
                    onPressed: onPressed,
                    icon: Icon(FontAwesomeIcons.exclamation, color: Theme.of(context).colorScheme.onSurfaceVariant))),
          ],
        ),
      ),
    );
  }
}
