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

    on<UpdateUserDetailEvent>(_handleUpdateUserDetail);
    on<UpdateProfilePictureEvent>(_handleUpdateProfilePicture);
    on<DeleteProfilePictureEvent>(_handleDeleteProfilePicture);
    on<FetchProfilePictureEvent>(_handleFetchProfilePicture);
  }

  _handleInitialize(InitializeEditUserProfileEvent event, Emitter<EditUserProfileViewState> emit) {
    emit(UserProfileEditing(
        id: event.id,
        firstName: event.firstName,
        lastName: event.lastName,
        bio: event.bio,
        imageData: event.imageData));
  }

  _handleUserProfileSaveRequested(UserProfileSaveRequestedEvent event, Emitter<EditUserProfileViewState> emit) {
    final editState = state as UserProfileEditing;
    _userProfileUseCase.updateUserProfile(
        id: editState.id,
        firstName: editState.firstName,
        lastName: editState.lastName,
        bio: editState.bio,
        imageData: editState.imageData,
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
    }
  }

  _handleUpdateProfilePicture(UpdateProfilePictureEvent event, Emitter<EditUserProfileViewState> emit) {
    final editState = state as UserProfileEditing;
    emit(editState.copyWith(imageData: event.imageData));
  }

  _handleUserProfileSaving(UserProfileSavingEvent event, Emitter<EditUserProfileViewState> emit) {
    emit(UserProfileSaving());
  }

  _handleUpdateUserProfileSuccess(UpdateProfileSuccessEvent event, Emitter<EditUserProfileViewState> emit) {
    emit(UserProfileEditSuccess());
  }

  _handleDeleteProfilePicture(DeleteProfilePictureEvent event, Emitter<EditUserProfileViewState> emit) async {
    final editState = state as UserProfileEditing;
    await _userProfileUseCase.deleteProfilePicture(editState.id);
    add(FetchProfilePictureEvent());
  }

  _handleFetchProfilePicture(FetchProfilePictureEvent event, Emitter<EditUserProfileViewState> emit) async {
    final editState = state as UserProfileEditing;
    final imageData = await _userProfileUseCase.fetchUserProfilePicture(editState.id);
    emit(editState.copyWith(imageData: imageData));
  }

  _handleOnUpdateProgress({required EditUserProfileStatus status}) {
    switch (status.runtimeType) {
      case const (EditStarted):
        return;
      case const (EditInProgress):
        add(UserProfileSavingEvent());
      case const (EditFailed):
        status as EditFailed;
        add(UpdateProfileFailedEvent(status.reason));
      case const (EditSuccess):
        add(UpdateProfileSuccessEvent());
    }
  }
}
