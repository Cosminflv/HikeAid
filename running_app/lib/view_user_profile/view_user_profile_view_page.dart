import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dart:typed_data';

import 'package:running_app/view_user_profile/view_user_profile_view_bloc.dart';
import 'package:running_app/view_user_profile/view_user_profile_view_state.dart';

class ViewUserProfileViewPage extends StatelessWidget {
  const ViewUserProfileViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ViewUserProfileViewBloc>.value(
      value: BlocProvider.of<ViewUserProfileViewBloc>(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(AppLocalizations.of(context)!.search,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.surface,
                  )),
        ),
        body: BlocBuilder<ViewUserProfileViewBloc, ViewUserProfileViewState>(builder: (context, state) {
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
