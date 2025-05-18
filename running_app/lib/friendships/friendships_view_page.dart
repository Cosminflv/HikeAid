import 'package:core/di/app_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/friendships/friendships_view_bloc.dart';
import 'package:running_app/friendships/friendships_view_state.dart';
import 'package:running_app/friendships/widgets/friendship_requests_list.dart';
import 'package:running_app/user_profile/user_profile_view_event.dart';
import 'package:running_app/utils/session_utils.dart';

class FriendshipsViewPage extends StatefulWidget {
  const FriendshipsViewPage({super.key});

  @override
  State<FriendshipsViewPage> createState() => _FriendshipsViewPageState();
}

class _FriendshipsViewPageState extends State<FriendshipsViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () {
              AppBlocs.userProfileBloc.add(FetchUserProfileEvent(userId: getSession(context)!.user.id));
              Navigator.of(context).pop(true);
            },
            icon: const Icon(FontAwesomeIcons.arrowLeft)),
        title: Text(
          "Friendship requests",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      body: BlocBuilder<FriendshipsViewBloc, FriendshipsViewState>(builder: (context, state) {
        return FriendshipRequestsList(
          requests: state.incomingRequests,
        );
      }),
    );
  }
}
