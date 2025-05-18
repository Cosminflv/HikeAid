import 'package:core/di/app_blocs.dart';
import 'package:domain/entities/friendship_entity.dart';
import 'package:domain/entities/search_user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/config/routes.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_event.dart';
import 'package:running_app/friendships/friendships_view_bloc.dart';
import 'package:running_app/friendships/friendships_view_events.dart';
import 'package:running_app/friendships/friendships_view_state.dart';
import 'package:running_app/onboarding/auth_session/auth_session_bloc.dart';
import 'package:running_app/onboarding/auth_session/auth_session_events.dart';
import 'package:running_app/onboarding/authentication/authentication_view_event.dart';
import 'package:running_app/position_prediction/position_prediction_events.dart';
import 'package:running_app/search_users/search_users_view_event.dart';
import 'package:running_app/shared_widgets/custom_text_button.dart';
import 'package:running_app/shared_widgets/dialogs/logout_confirm_dialog.dart';
import 'package:running_app/user_profile/user_profile_view_bloc.dart';
import 'package:running_app/user_profile/user_profile_view_state.dart';
import 'package:running_app/user_profile/widgets/friend_status_button.dart';
import 'package:running_app/user_profile/widgets/profile_image_dialog.dart';
import 'package:running_app/user_profile/widgets/remove_friend_dialog.dart';
import 'package:running_app/user_profile/widgets/tour_card.dart';
import 'package:running_app/user_profile/widgets/view_hike_button.dart';

// ignore: must_be_immutable
class UserProfileViewPage extends StatefulWidget {
  final bool isEditable;
  FriendshipStatus? friendshipStatus;
  FriendshipEntity? friendRequest;

  UserProfileViewPage({super.key, required this.isEditable, this.friendshipStatus, this.friendRequest});

  @override
  State<UserProfileViewPage> createState() => _UserProfileViewPageState();
}

class _UserProfileViewPageState extends State<UserProfileViewPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserProfileBloc>.value(
      value: BlocProvider.of<UserProfileBloc>(context),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: !widget.isEditable,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: widget.isEditable
              ? TextButton(
                  onPressed: () {
                    showLogoutConfirmation(context).then((hasConfirmed) {
                      if (hasConfirmed) {
                        BlocProvider.of<AuthSessionBloc>(context).add(LogoutEvent());
                        AppBlocs.authenticationViewBloc.add(AuthResetEvent());
                      }
                    });
                  },
                  child: Text(
                    AppLocalizations.of(context)!.logoutTitle,
                    style:
                        Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.surface),
                  ),
                )
              : Text(
                  AppLocalizations.of(context)!.search,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.surface),
                ),
          actions: widget.isEditable
              ? [
                  IconButton(
                      onPressed: () => Navigator.of(context).pushNamed(RouteNames.searchUsersPage),
                      icon: Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: Theme.of(context).colorScheme.surface,
                      )),
                  BlocBuilder<FriendshipsViewBloc, FriendshipsViewState>(
                    builder: (context, state) {
                      return IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(RouteNames.friendshipRequests).then((result) {
                              if (result == true) {
                                // Trigger a state update to rebuild the previous page
                                setState(() {});
                              }
                            });
                          },
                          icon: Icon(
                            FontAwesomeIcons.bell,
                            color: state.incomingRequests.isNotEmpty
                                ? const Color.fromARGB(255, 222, 134, 33)
                                : Theme.of(context).colorScheme.surface,
                          ));
                    },
                    buildWhen: (previous, current) =>
                        previous.incomingRequests.length != current.incomingRequests.length,
                  )
                ]
              : null,
        ),
        body: BlocBuilder<UserProfileBloc, UserProfileViewState>(builder: (context, state) {
          if (state is InitialProfileState) {
            return const SizedBox.shrink();
          }
          if (state is UserProfileLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserProfileLoadFailState) {
            return Material(
              type: MaterialType.transparency,
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.userProfileFail,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          state as UserProfileLoadedState;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  color: Theme.of(context).highlightColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                profileImageDialog(context, state.profile.imageData);
                              },
                              child: CircleAvatar(
                                backgroundImage: MemoryImage(state.profile.imageData),
                                radius: 30.0,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${state.profile.firstName} ${state.profile.lastName}",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  state.profile.username,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          state.profile.bio,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15.0),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Friends", style: Theme.of(context).textTheme.bodySmall),
                                Text(
                                  state.profile.friendsCount.toString(),
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 20.0),
                                ),
                              ],
                            ),
                            if (widget.isEditable)
                              SizedBox(
                                height: 40,
                                width: 100,
                                child: CustomElevatedButton(
                                  backgroundColor: Theme.of(context).brightness == Brightness.light
                                      ? Theme.of(context).colorScheme.tertiary
                                      : Theme.of(context).colorScheme.onSurface,
                                  text: AppLocalizations.of(context)!.edit,
                                  textColor: Theme.of(context).colorScheme.surface,
                                  trailing: Icon(
                                    FontAwesomeIcons.pen,
                                    color: Theme.of(context).colorScheme.surface,
                                    size: 15,
                                  ),
                                  onTap: () {
                                    AppBlocs.editProfileBloc.add(InitializeEditUserProfileEvent(
                                      id: state.profile.id,
                                      firstName: state.profile.firstName,
                                      lastName: state.profile.lastName,
                                      bio: state.profile.bio,
                                      city: state.profile.city,
                                      age: state.profile.age,
                                      weight: state.profile.weight,
                                      country: state.profile.country,
                                      gender: state.profile.gender,
                                      birthDate: state.profile.birthDate,
                                      imageData: state.profile.imageData,
                                    ));
                                    Navigator.of(context)
                                        .pushNamed(RouteNames.editProfilePage, arguments: state.profile);
                                  },
                                ),
                              ),
                            if (widget.friendshipStatus != null)
                              FriendshipButton(
                                status: widget.friendshipStatus!,
                                onAddFriend: () {
                                  AppBlocs.searchUsersBloc.add(AddFriendEvent(state.profile.id));
                                  setState(() {
                                    widget.friendshipStatus = FriendshipStatus.pending;
                                  });
                                },
                                onAcceptRequest: () {
                                  AppBlocs.friendships
                                      .add(AcceptFriendshipRequestEvent(request: widget.friendRequest!));
                                  setState(() {
                                    widget.friendshipStatus = FriendshipStatus.friends;
                                  });
                                },
                                onCancelRequest: () {
                                  setState(() {
                                    widget.friendshipStatus = FriendshipStatus.none;
                                  });
                                },
                                onRemoveFriend: () {
                                  showUnfriendConfirmation(
                                      context, "${state.profile.firstName} ${state.profile.lastName}");
                                },
                              ),
                            if (widget.friendshipStatus != null)
                              ViewHikeButton(onPressed: () {
                                AppBlocs.positionPredictionBloc.add(
                                  GetCurrentHikeEvent(state.profile.id),
                                );
                                Navigator.of(context).pushNamed(RouteNames.userCurrentHikePage,
                                    arguments: {"userName": state.profile.username, "userId": state.profile.id});
                              }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BlocBuilder<UserProfileBloc, UserProfileViewState>(
                buildWhen: (previous, current) =>
                    previous is UserProfileLoadedState &&
                    current is UserProfileLoadedState &&
                    previous.tours.length != current.tours.length,
                builder: (context, state) {
                  if (state is UserProfileLoadedState) {
                    // Show a placeholder when there are no recorded hikes
                    if (state.tours.isEmpty) {
                      return const Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.directions_walk,
                                size: 64,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'No recorded hikes',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    // Show the list of tours when available
                    return Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.tours.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final tour = state.tours[index];
                          return TourCard(tour: tour);
                        },
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
