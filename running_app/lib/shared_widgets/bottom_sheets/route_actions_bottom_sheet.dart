import 'package:flutter/material.dart';
import 'package:running_app/routing/widgets/route_actions_panel.dart';

class RouteActionsBottomSheet {
  static PersistentBottomSheetController? _controller;

  static bool get isOpened => _controller != null;

  static void show(BuildContext context) {
    _controller = showBottomSheet(
      enableDrag: false,
      context: context,
      sheetAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
      ),
      builder: (buildContext) => SizedBox(
        width: MediaQuery.of(buildContext).size.width,
        child: RouteActionsPanel(
          pageContext: context,
        ),
      ),
    );

    _controller?.closed.then((val) {
      _controller = null;
    });
  }

  static void close() {
    if (_controller != null) {
      _controller!.close();
    }
  }
}
