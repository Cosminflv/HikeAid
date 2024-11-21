import 'package:flutter/material.dart';

class DisablingWidget extends StatelessWidget {
  final bool isDisabled;
  final Widget child;

  const DisablingWidget({super.key, required this.isDisabled, required this.child});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDisabled ? 0.5 : 1,
      child: AbsorbPointer(absorbing: isDisabled, child: child),
    );
  }
}
