import 'package:domain/use_cases/search_users_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/providers/bloc_providers.dart';
import 'package:running_app/search_users/search_users_view_event.dart';
import 'package:running_app/search_users/search_users_view_state.dart';
import 'package:running_app/search_users/serach_users_view_bloc.dart';
import 'package:running_app/search_users/widgets/search_list_view.dart';
import 'package:running_app/shared_widgets/search_text_field.dart';

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
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          BlocBuilder<SearchUsersBloc, SearchUsersState>(
              bloc: searchUsersBloc,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SearchTextField(
                    controller: _controller,
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
          const SearchListView(),
        ],
      ),
    );
  }
}
