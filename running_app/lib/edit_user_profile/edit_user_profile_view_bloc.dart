import 'package:core/di/injection_container.dart';
import 'package:domain/entities/edit_user_profile_status.dart';
import 'package:domain/use_cases/user_profile_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_event.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_state.dart';

class EditUserProfileViewBloc extends Bloc<EditUserProfileViewEvent, EditUserProfileViewState> {
  final _userProfileUseCase = sl.get<UserProfileUseCase>();

  EditUserProfileViewBloc() : super(UserProfileInitial()) {
    on<InitializeEditUserProfileEvent>(_handleInitialize);
    on<UserProfileSaveRequestedEvent>(_handleUserProfileSaveRequested);

    on<UserProfileSavingEvent>(_handleUserProfileSaving);
    on<UpdateProfileSuccessEvent>(_handleUpdateUserProfileSuccess);
    on<UpdateProfileFailedEvent>(_handleUpdateFailedEvent);

    on<UpdateUserDetailEvent>(_handleUpdateUserDetail);
    on<UpdateUserBirthDateEvent>(_handleUpdateBirthDate);
    on<UpdateUserGenderEvent>(_handleUpdateUserGender);
    on<UpdateUserWeightEvent>(_handleUpdateUserWeight);
    on<UpdateProfilePictureEvent>(_handleUpdateProfilePicture);
    on<DeleteProfilePictureEvent>(_handleDeleteProfilePicture);
    on<FetchDefaultProfilePictureEvent>(_handleFetchDefaultProfilePicture);
  }

  _handleInitialize(InitializeEditUserProfileEvent event, Emitter<EditUserProfileViewState> emit) {
    emit(UserProfileEditing(
      id: event.id,
      firstName: event.firstName,
      lastName: event.lastName,
      bio: event.bio,
      city: event.city,
      country: event.country,
      age: event.age,
      weight: event.weight,
      gender: event.gender,
      birthDate: event.birthDate,
      imageData: event.imageData,
      hasDeletedImage: false,
    ));
  }

  _handleUserProfileSaveRequested(UserProfileSaveRequestedEvent event, Emitter<EditUserProfileViewState> emit) {
    final editState = state as UserProfileEditing;
    _userProfileUseCase.updateUserProfile(
        firstName: editState.firstName,
        lastName: editState.lastName,
        bio: editState.bio,
        city: editState.city,
        country: editState.country,
        age: editState.age,
        weight: editState.weight,
        gender: editState.gender,
        birthDate: editState.birthDate,
        imageData: editState.imageData,
        hasDeletedImage: editState.hasDeletedImage,
        onUpdateProgress: (status) => _handleOnUpdateProgress(status: status));
  }

  _handleUpdateUserDetail(UpdateUserDetailEvent event, Emitter<EditUserProfileViewState> emit) {
    final editState = state as UserProfileEditing;
    switch (event.type) {
      case UserDetailType.firstName:
        emit(editState.copyWith(firstName: event.value));
        break;
      case UserDetailType.lastName:
        emit(editState.copyWith(lastName: event.value));
        break;
      case UserDetailType.bio:
        emit(editState.copyWith(bio: event.value));
        break;
      case UserDetailType.city:
        emit(editState.copyWith(city: event.value));
        break;
      case UserDetailType.country:
        emit(editState.copyWith(country: event.value));
        break;
    }
  }

  _handleUpdateBirthDate(UpdateUserBirthDateEvent event, Emitter<EditUserProfileViewState> emit) {
    final editState = state as UserProfileEditing;
    emit(editState.copyWith(birthDate: event.newDateTime));
  }

  _handleUpdateUserGender(UpdateUserGenderEvent event, Emitter<EditUserProfileViewState> emit) {
    final editState = state as UserProfileEditing;
    emit(editState.copyWith(gender: event.newGender));
  }

  _handleUpdateUserWeight(UpdateUserWeightEvent event, Emitter<EditUserProfileViewState> emit) {
    final editState = state as UserProfileEditing;
    emit(editState.copyWith(weight: event.newWeight));
  }

  _handleUpdateProfilePicture(UpdateProfilePictureEvent event, Emitter<EditUserProfileViewState> emit) {
    final editState = state as UserProfileEditing;
    emit(editState.copyWith(imageData: event.imageData, hasDeletedImage: false));
  }

  _handleDeleteProfilePicture(DeleteProfilePictureEvent event, Emitter<EditUserProfileViewState> emit) async {
    final editState = state as UserProfileEditing;
    emit(editState.copyWith(hasDeletedImage: true));
    add(FetchDefaultProfilePictureEvent());
  }

  _handleUserProfileSaving(UserProfileSavingEvent event, Emitter<EditUserProfileViewState> emit) {
    emit(UserProfileSaving());
  }

  _handleUpdateUserProfileSuccess(UpdateProfileSuccessEvent event, Emitter<EditUserProfileViewState> emit) {
    emit(UserProfileEditSuccess());
  }

  _handleUpdateFailedEvent(UpdateProfileFailedEvent event, Emitter<EditUserProfileViewState> emit) {
    emit(UserProfileEditFailed(event.reason));
  }

  _handleFetchDefaultProfilePicture(
      FetchDefaultProfilePictureEvent event, Emitter<EditUserProfileViewState> emit) async {
    final editState = state as UserProfileEditing;
    final imageData = await _userProfileUseCase.fetchDefaultUserProfilePicture(editState.id);
    emit(editState.copyWith(imageData: imageData));
  }

  _handleOnUpdateProgress({required EditUserProfileStatus status}) {
    switch (status.runtimeType) {
      case EditStarted:
        return;
      case EditInProgress:
        add(UserProfileSavingEvent());
      case EditFailed:
        status as EditFailed;
        add(UpdateProfileFailedEvent(status.reason));
      case EditSuccess:
        add(UpdateProfileSuccessEvent());
    }
  }
}
