import 'package:running_app/app/app_bloc.dart';
import 'package:running_app/app/app_state.dart';
import 'package:running_app/map/map_view_page.dart';
import 'package:running_app/user_profile/user_profile_view_page.dart';
import 'package:running_app/utils/sizes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeViewPage extends StatefulWidget {
  const HomeViewPage({super.key});

  @override
  State<HomeViewPage> createState() => _HomeViewPageState();
}

class _HomeViewPageState extends State<HomeViewPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      bottomNavigationBar: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          Sizes.updateStatusBarHeight(MediaQuery.of(context).padding.top);
          Sizes.updateBottomPadding(MediaQuery.of(context).padding.bottom);

          return Container(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, boxShadow: [
              BoxShadow(blurRadius: 0, spreadRadius: 1, color: Theme.of(context).colorScheme.outlineVariant)
            ]),
            child: BottomNavigationBar(
              elevation: 0,
              currentIndex: _currentIndex,
              backgroundColor: Theme.of(context).colorScheme.surface,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              enableFeedback: true,
              onTap: (index) {
                setState(() => _currentIndex = index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      _currentIndex == 0 ? FontAwesomeIcons.solidMap : FontAwesomeIcons.map,
                      weight: 20,
                    ),
                    label: AppLocalizations.of(context)!.routes),
                BottomNavigationBarItem(
                    icon: Icon(_currentIndex == 1 ? FontAwesomeIcons.solidUser : FontAwesomeIcons.user),
                    label: AppLocalizations.of(context)!.profile),
              ],
            ),
          );
        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          MapViewPage(),
          UserProfileViewPage(),
        ],
      ),
    );
  }
}
