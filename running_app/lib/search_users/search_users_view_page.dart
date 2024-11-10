import 'package:domain/use_cases/search_users_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/providers/bloc_providers.dart';
import 'package:running_app/search_users/search_users_view_event.dart';
import 'package:running_app/search_users/search_users_view_state.dart';
import 'package:running_app/search_users/search_users_view_bloc.dart';
import 'package:running_app/search_users/widgets/search_list_view.dart';
import 'package:running_app/shared_widgets/search_text_field.dart';
import 'package:running_app/utils/session_utils.dart';

class SearchUsersViewPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  SearchUsersViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchUsersBloc = BlocProviders.searchUsers(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          AppLocalizations.of(context)!.search,
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
                    child: SearchTextField(
                      controller: _controller,
                      onChanged: (text) {
                        final userSearching = getSession(context)!.user.id;
                        searchUsersBloc.add(SearchUserEvent(text: text, userId: userSearching));
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
                  return SearchListView(
                      users: displayedItems,
                      onItemTap: (user) {
                        //TODO: Navigate to user profile
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
