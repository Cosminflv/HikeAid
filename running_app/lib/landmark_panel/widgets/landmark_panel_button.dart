import 'package:flutter/material.dart';

class LandmarkPanelButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isFilled;
  final Color? color;

  const LandmarkPanelButton({super.key, required this.text, required this.onTap, required this.isFilled, this.color});

  @override
  Widget build(BuildContext context) {
    final buttonWidth = MediaQuery.of(context).size.width / 2 - 30;

    return SizedBox(
      height: 40,
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.surface,
        highlightColor: Theme.of(context).colorScheme.surface,
        onTap: onTap,
        child: Container(
          width: buttonWidth,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: isFilled == true ? null : Border.all(color: Theme.of(context).colorScheme.primary),
              color: isFilled == true ? color ?? Theme.of(context).colorScheme.primary : null),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 14,
                  color: isFilled == true
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
      ),
    );
  }
}
