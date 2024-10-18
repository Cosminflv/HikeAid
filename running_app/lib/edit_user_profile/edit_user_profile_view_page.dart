import 'package:domain/entities/user_profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_bloc.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_event.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:running_app/edit_user_profile/edit_user_profile_view_state.dart';
import 'package:running_app/providers/bloc_providers.dart';
import 'package:running_app/shared_widgets/custom_text_field.dart';
import 'package:running_app/shared_widgets/dialogs/date_picker_dialog.dart';
import 'package:running_app/shared_widgets/dialogs/gender_date_picker.dart';
import 'package:running_app/shared_widgets/dialogs/image_action_dialog.dart';
import 'package:running_app/shared_widgets/dialogs/weight_picker_dialog.dart';
import 'package:running_app/user_profile/user_profile_view_event.dart';
import 'package:running_app/utils/converters.dart';
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
  late TextEditingController cityController;
  late TextEditingController countryController;

  @override
  void initState() {
    super.initState();

    // Initialize the text controllers with the profile data
    firstNameController = TextEditingController(text: widget.profile.firstName);
    lastNameController = TextEditingController(text: widget.profile.lastName);
    bioController = TextEditingController(text: widget.profile.bio);
    cityController = TextEditingController(text: widget.profile.city);
    countryController = TextEditingController(text: widget.profile.country);
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed
    firstNameController.dispose();
    lastNameController.dispose();
    bioController.dispose();
    cityController.dispose();
    countryController.dispose();
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
                  // Defer the showing of SnackBar until after the current frame
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppLocalizations.of(context)!.updateFailed),
                        backgroundColor: Colors.red, // Red background for error
                        duration: const Duration(seconds: 2), // Duration the snackbar will be visible
                      ),
                    );
                  });
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
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          CustomTextField(
                            textController: firstNameController,
                            onChanged: (value) => BlocProviders.editProfile(context)
                                .add(UpdateUserDetailEvent(type: UserDetailType.firstName, value: value)),
                            hintText: "First Name",
                          ),
                          Divider(
                            color: Theme.of(context).hoverColor,
                          ),
                          CustomTextField(
                            textController: lastNameController,
                            onChanged: (value) => BlocProviders.editProfile(context)
                                .add(UpdateUserDetailEvent(type: UserDetailType.lastName, value: value)),
                            hintText: "Last Name",
                          ),
                        ],
                      ),
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
                  CustomTextField(
                    textController: bioController,
                    onChanged: (value) => BlocProviders.editProfile(context)
                        .add(UpdateUserDetailEvent(type: UserDetailType.bio, value: value)),
                    hintText: "Bio",
                  ),
                  CustomTextField(
                    textController: countryController,
                    onChanged: (value) => BlocProviders.editProfile(context)
                        .add(UpdateUserDetailEvent(type: UserDetailType.country, value: value)),
                    hintText: "Country",
                  ),
                  CustomTextField(
                    textController: cityController,
                    onChanged: (value) => BlocProviders.editProfile(context)
                        .add(UpdateUserDetailEvent(type: UserDetailType.city, value: value)),
                    hintText: "City",
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            //color: Theme.of(context).highlightColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "ATHLETE INFORMATION",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          BlocBuilder<EditUserProfileViewBloc, EditUserProfileViewState>(
            buildWhen: (previous, current) => current is UserProfileEditing,
            builder: (context, state) {
              state as UserProfileEditing;
              return GestureDetector(
                onTap: () => showCupertinoDatePickerDialog(context, state.birthDate),
                child: Container(
                    color: Theme.of(context).highlightColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Select Birthdate"),
                          Text(
                              "${state.birthDate.day} ${convertMonthToString(state.birthDate.month)} ${state.birthDate.year}"),
                        ],
                      ),
                    )),
              );
            },
          ),
          BlocBuilder<EditUserProfileViewBloc, EditUserProfileViewState>(
            buildWhen: (previous, current) => current is UserProfileEditing,
            builder: (context, state) {
              state as UserProfileEditing;
              return GestureDetector(
                onTap: () => showCupertinoEnumPickerDialog(context, state.gender),
                child: Container(
                    color: Theme.of(context).highlightColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Gender"),
                          Text(state.gender.toReadableString()),
                        ],
                      ),
                    )),
              );
            },
          ),
          BlocBuilder<EditUserProfileViewBloc, EditUserProfileViewState>(
            buildWhen: (previous, current) => current is UserProfileEditing,
            builder: (context, state) {
              state as UserProfileEditing;
              return GestureDetector(
                onTap: () => showCupertinoWeightPickerDialog(context, state.weight),
                child: Container(
                    color: Theme.of(context).highlightColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Weight (kg)"),
                          Text(state.weight.toString()),
                        ],
                      ),
                    )),
              );
            },
          )
        ],
      ),
    );
  }
}
