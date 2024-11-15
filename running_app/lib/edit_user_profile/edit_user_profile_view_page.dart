import 'package:domain/entities/user_profile_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/edit_user_profile/dialogs/enum_picker_dialog.dart';
import 'package:running_app/edit_user_profile/dialogs/profile_item_picker.dart';
import 'package:running_app/edit_user_profile/dialogs/weight_picker_dialog.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_bloc.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_event.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:running_app/edit_user_profile/edit_user_profile_view_state.dart';
import 'package:running_app/providers/bloc_providers.dart';
import 'package:running_app/shared_widgets/custom_text_field.dart';
import 'package:running_app/edit_user_profile/dialogs/date_picker_dialog.dart';
import 'package:running_app/shared_widgets/dialogs/image_action_dialog.dart';
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
  // Controllers for text fields
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController bioController;
  late TextEditingController cityController;
  late TextEditingController countryController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.profile.firstName);
    lastNameController = TextEditingController(text: widget.profile.lastName);
    bioController = TextEditingController(text: widget.profile.bio);
    cityController = TextEditingController(text: widget.profile.city);
    countryController = TextEditingController(text: widget.profile.country);
  }

  @override
  void dispose() {
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
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context),
            _buildDetailsSection(context),
            const SizedBox(height: 15),
            _buildAthleteInformationTitle(context),
            const SizedBox(height: 15),
            _buildAthleteInformation(context),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          AppLocalizations.of(context)!.cancel,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      backgroundColor: Theme.of(context).highlightColor,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: BlocBuilder<EditUserProfileViewBloc, EditUserProfileViewState>(
            builder: (context, state) => _buildSaveButton(context, state),
          ),
        )
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context, EditUserProfileViewState state) {
    if (state is UserProfileSaving) {
      return const CircularProgressIndicator();
    }
    if (state is UserProfileEditSuccess) {
      BlocProviders.userProfile(context).add(FetchUserProfileEvent(session: getSession(context)));
      Navigator.of(context).pop();
    }
    if (state is UserProfileEditFailed) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.updateFailed),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      });
    }
    if (state is UserProfileEditing) {
      return TextButton(
        onPressed: () {
          BlocProviders.editProfile(context).add(UserProfileSaveRequestedEvent());
        },
        child: Text(
          AppLocalizations.of(context)!.save,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Padding(
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
            child: _buildNameFields(context),
          )
        ],
      ),
    );
  }

  Widget _buildNameFields(BuildContext context) {
    return Container(
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
            Divider(color: Theme.of(context).hoverColor),
            CustomTextField(
              textController: lastNameController,
              onChanged: (value) => BlocProviders.editProfile(context)
                  .add(UpdateUserDetailEvent(type: UserDetailType.lastName, value: value)),
              hintText: "Last Name",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    return Container(
      color: Theme.of(context).highlightColor,
      child: IntrinsicHeight(
        child: Column(
          children: [
            CustomTextField(
              textController: bioController,
              onChanged: (value) =>
                  BlocProviders.editProfile(context).add(UpdateUserDetailEvent(type: UserDetailType.bio, value: value)),
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
    );
  }

  Widget _buildAthleteInformationTitle(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          "ATHLETE INFORMATION",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }

  Widget _buildAthleteInformation(BuildContext context) {
    return BlocBuilder<EditUserProfileViewBloc, EditUserProfileViewState>(
      buildWhen: (previous, current) => current is UserProfileEditing,
      builder: (context, state) {
        state as UserProfileEditing;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileItemPicker<DateTime>(
              title: "Select Birthdate",
              value: "${state.birthDate.day} ${convertMonthToString(state.birthDate.month)} ${state.birthDate.year}",
              onTap: (context) => showCupertinoModalPopup(
                context: context,
                builder: (_) => CupertinoDatePickerDialog(currentBirthDate: state.birthDate),
              ),
            ),
            ProfileItemPicker<String>(
              title: "Gender",
              value: state.gender.toReadableString(),
              onTap: (context) => showCupertinoModalPopup(
                context: context,
                builder: (_) => CupertinoEnumPickerDialog(currentGender: state.gender),
              ),
            ),
            ProfileItemPicker<int>(
              title: "Weight (kg)",
              value: state.weight.toString(),
              onTap: (context) => showCupertinoModalPopup(
                context: context,
                builder: (_) => CupertinoWeightPickerDialog(currentWeight: state.weight),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Used to calculate calories, power and more",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        );
      },
    );
  }
}
