import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;

  const CustomIconButton({
    super.key,
    required this.onTap,
    required this.child,
  });

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: widget.onTap,
        onTapDown: (TapDownDetails details) {
          setState(() {
            _isPressed = true;
          });
        },
        onTapUp: (TapUpDetails details) {
          setState(() {
            _isPressed = false;
          });
        },
        onTapCancel: () {
          setState(() {
            _isPressed = false;
          });
        },
        child: Opacity(opacity: _isPressed ? 0.5 : 1, child: widget.child),
      ),
    );
  }
}
