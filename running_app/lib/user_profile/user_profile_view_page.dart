import 'package:domain/entities/auth_session_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/config/routes.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_event.dart';
import 'package:running_app/onboarding/auth_session/auth_session_bloc.dart';
import 'package:running_app/onboarding/auth_session/auth_session_events.dart';
import 'package:running_app/onboarding/authentication/authentication_view_event.dart';
import 'package:running_app/providers/bloc_providers.dart';
import 'package:running_app/shared_widgets/custom_text_button.dart';
import 'package:running_app/shared_widgets/dialogs/logout_confirm_dialog.dart';
import 'package:running_app/user_profile/user_profile_view_bloc.dart';
import 'package:running_app/user_profile/user_profile_view_state.dart';

import 'dart:typed_data';

class UserProfileViewPage extends StatelessWidget {
  final AuthSessionEntity? session;
  const UserProfileViewPage({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserProfileViewBloc>.value(
      value: BlocProvider.of<UserProfileViewBloc>(context),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: TextButton(
            onPressed: () {
              showLogoutConfirmation(context).then((hasConfirmed) {
                if (hasConfirmed) {
                  BlocProvider.of<AuthSessionBloc>(context).add(LogoutEvent());
                  BlocProviders.authentication(context).add(AuthResetEvent());
                }
              });
            },
            child: Text(
              AppLocalizations.of(context)!.logoutTitle,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.surface),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).pushNamed(RouteNames.searchUsersPage),
                icon: Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: Theme.of(context).colorScheme.surface,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.gear,
                  color: Theme.of(context).colorScheme.surface,
                ))
          ],
        ),
        body: BlocBuilder<UserProfileViewBloc, UserProfileViewState>(builder: (context, state) {
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
                            const SizedBox(
                              width: 20,
                            ),
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
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          state.profile.bio,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 20.0),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Friends",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  state.profile.friendsCount.toString(),
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 20.0),
                                )
                              ],
                            ),
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
                                  BlocProviders.editProfile(context).add(InitializeEditUserProfileEvent(
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
                                  Navigator.of(context).pushNamed(RouteNames.editProfilePage, arguments: state.profile);
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Future<dynamic> profileImageDialog(BuildContext context, Uint8List imageData) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Center(
                child: Image.memory(imageData),
              ),
              Positioned(
                top: 1,
                right: 1,
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.x,
                    color: Theme.of(context).colorScheme.onSecondary,
                    size: 20.0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
