import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      this.text,
      this.leading,
      this.textColor,
      required this.backgroundColor,
      this.onTap,
      this.alignment,
      this.trailing});

  final String? text;
  final Widget? leading;
  final Widget? trailing;
  final Color? textColor;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final MainAxisAlignment? alignment;

  final _borderRadius = 10.0;
  @override
  Widget build(BuildContext context) {
    return PlatformElevatedButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      color: backgroundColor,
      cupertino: (context, platform) => CupertinoElevatedButtonData(
          disabledColor: Theme.of(context).colorScheme.onSurfaceVariant,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(_borderRadius)),
      material: (context, platform) => MaterialElevatedButtonData(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.zero,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
        ),
      ),
      child: SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: alignment ?? MainAxisAlignment.start,
            children: [
              if (leading != null)
                SizedBox(
                  width: 20,
                  child: leading!,
                ),
              if (leading != null)
                const SizedBox(
                  width: 10,
                ),
              if (text != null)
                Expanded(
                  child: Text(
                    text!,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(color: textColor),
                  ),
                ),
              if (trailing != null)
                SizedBox(
                  width: 20,
                  child: trailing,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
