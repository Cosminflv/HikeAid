import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/config/routes.dart';

import '../app/app_bloc.dart';
import '../app/app_state.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final bool automaticallyImplyLeading;
  final bool isInMapView;

  const SearchAppBar({super.key, required this.title, this.automaticallyImplyLeading = true, this.isInMapView = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state.isNavigating && isInMapView || state.isRecording || state.isDrawing) {
          return const SizedBox.shrink();
        }
        return AppBar(
          automaticallyImplyLeading: automaticallyImplyLeading,
          iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
          leadingWidth: 30,
          toolbarHeight: 60,
          title: Container(
              padding: const EdgeInsets.symmetric(vertical: 2),
              width: MediaQuery.of(context).size.width - 50,
              height: 40,
              child: title),
          actions: [
            IconButton(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              icon: const Icon(FontAwesomeIcons.gear),
              onPressed: () {
                Navigator.of(context).pushNamed(RouteNames.settingsPage);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
