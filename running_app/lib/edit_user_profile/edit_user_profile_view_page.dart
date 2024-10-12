import 'package:domain/entities/user_profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_bloc.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_event.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:running_app/edit_user_profile/edit_user_profile_view_state.dart';
import 'package:running_app/providers/bloc_providers.dart';
import 'package:running_app/shared_widgets/dialogs/image_action_dialog.dart';
import 'package:running_app/user_profile/user_profile_view_event.dart';
import 'package:running_app/utils/session_utils.dart';

class EditUserProfileViewPage extends StatefulWidget {
  final UserProfileEntity profile;
  const EditUserProfileViewPage({super.key, required this.profile});

  @override
  State<EditUserProfileViewPage> createState() => _EditUserProfileViewPageState();
}

class _EditUserProfileViewPageState extends State<EditUserProfileViewPage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController bioController;

  @override
  void initState() {
    super.initState();

    // Initialize the text controllers with the profile data
    firstNameController = TextEditingController(text: widget.profile.firstName ?? '');
    lastNameController = TextEditingController(text: widget.profile.lastName ?? '');
    bioController = TextEditingController(text: widget.profile.bio ?? '');
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed
    firstNameController.dispose();
    lastNameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: BlocBuilder<EditUserProfileViewBloc, EditUserProfileViewState>(
              builder: (context, state) {
                if (state is UserProfileSaving) {
                  return const CircularProgressIndicator();
                }

                if (state is UserProfileEditSuccess) {
                  BlocProviders.userProfile(context).add(FetchUserProfileEvent(getSession(context)));
                  Navigator.of(context).pop();
                }

                if (state is UserProfileEditFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocalizations.of(context)!.updateFailed),
                      backgroundColor: Colors.red, // Red background for error
                      duration: const Duration(seconds: 2), // Duration the snackbar will be visible
                    ),
                  );
                }

                if (state is UserProfileEditing) {
                  return TextButton(
                    onPressed: () {
                      BlocProviders.editProfile(context).add(UserProfileSaveRequestedEvent());
                    },
                    child: Text(AppLocalizations.of(context)!.save,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Theme.of(context).colorScheme.onSurface)),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          )
        ],
        title: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.cancel,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface)),
        ),
        backgroundColor: Theme.of(context).highlightColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: BlocBuilder<EditUserProfileViewBloc, EditUserProfileViewState>(
                    buildWhen: (previous, current) => previous != current && current is UserProfileEditing,
                    builder: (context, state) {
                      if (state is UserProfileEditing) {
                        return GestureDetector(
                          onTap: () => showEditImageActions(context),
                          child: CircleAvatar(
                            backgroundImage: MemoryImage(state.imageData),
                            radius: 35.0,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Theme.of(context).highlightColor,
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (value) => BlocProviders.editProfile(context)
                              .add(UpdateUserDetailEvent(type: UserDetailType.firstName, value: value)),
                          controller: firstNameController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15.0),
                              hintText: AppLocalizations.of(context)!.firstName),
                        ),
                        Divider(
                          color: Theme.of(context).hoverColor,
                        ),
                        TextField(
                          onChanged: (value) => BlocProviders.editProfile(context)
                              .add(UpdateUserDetailEvent(type: UserDetailType.lastName, value: value)),
                          controller: lastNameController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15.0),
                              hintText: AppLocalizations.of(context)!.lastName),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Theme.of(context).highlightColor,
            child: IntrinsicHeight(
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) => BlocProviders.editProfile(context)
                        .add(UpdateUserDetailEvent(type: UserDetailType.bio, value: value)),
                    controller: bioController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15.0),
                        hintText: "Bio"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
