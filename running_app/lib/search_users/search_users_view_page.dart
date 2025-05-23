import 'package:core/di/app_blocs.dart';
import 'package:domain/entities/search_status.dart';
import 'package:running_app/config/routes.dart';
import 'package:running_app/search_users/search_users_view_event.dart';
import 'package:running_app/search_users/search_users_view_state.dart';
import 'package:running_app/search_users/search_users_view_bloc.dart';
import 'package:running_app/search_users/widgets/search_list_view.dart';
import 'package:running_app/shared_widgets/search_users_text_field.dart';
import 'package:running_app/user_profile/user_profile_view_event.dart';
import 'package:running_app/utils/session_utils.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchUsersViewPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  SearchUsersViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchUsersBloc = AppBlocs.searchUsersBloc;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
            onPressed: () {
              AppBlocs.userProfileBloc.add(FetchUserProfileEvent(userId: getSession(context)!.user.id));
              Navigator.of(context).pop();
            },
            icon: const Icon(FontAwesomeIcons.arrowLeft)),
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.surface),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<SearchUsersBloc, SearchUsersState>(
                bloc: searchUsersBloc,
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SearchUsersTextField(
                      controller: _controller,
                      onChanged: (text) {
                        searchUsersBloc.add(SearchUserEvent(text: text));
                        if (text.isEmpty) {
                          searchUsersBloc.add(ClearSearchEvent());
                        }
                      },
                      suffix: (state.status != SearchStatus.none)
                          ? IconButton(
                              onPressed: () {
                                searchUsersBloc.add(ClearSearchEvent());
                                _controller.text = '';
                              },
                              icon: Icon(
                                FontAwesomeIcons.circleXmark,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ))
                          : null,
                    ),
                  );
                }),
            BlocBuilder<SearchUsersBloc, SearchUsersState>(
              bloc: searchUsersBloc,
              builder: (context, state) {
                var displayedItems = state.results;
                if (state.status == SearchStatus.started) {
                  return const CircularProgressIndicator();
                }

                if (state.status == SearchStatus.ended && displayedItems.isNotEmpty) {
                  return SearchUsersListView(
                      users: displayedItems,
                      onItemTap: (user) {
                        AppBlocs.userProfileBloc.add(FetchUserProfileEvent(userId: user.id));
                        AppBlocs.userProfileBloc.add(FetchUserTours(userId: user.id));
                        Navigator.of(context).pushNamed(
                          RouteNames.userProfilePage,
                          arguments: {'isEditable': false, 'friendshipStatus': user.friendshipStatus},
                        );
                      });
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
