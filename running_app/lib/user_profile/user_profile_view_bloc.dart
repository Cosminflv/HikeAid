import 'package:core/di/injection_container.dart';
import 'package:domain/use_cases/user_profile_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/user_profile/user_profile_view_event.dart';
import 'package:running_app/user_profile/user_profile_view_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileViewState> {
  final UserProfileUseCase _userProfileUseCase = sl.get<UserProfileUseCase>();

  UserProfileBloc() : super(InitialProfileState()) {
    on<FetchUserProfileEvent>(_handleFetchUserProfile);
  }

  Future<void> _handleFetchUserProfile(FetchUserProfileEvent event, Emitter<UserProfileViewState> emit) async {
    emit(UserProfileLoadingState());

    // Determine whether to fetch authenticated user's profile or another user's profile.
    final profile = event.session != null
        ? await _userProfileUseCase.getAuthenticatedUserProfile(event.session!.user.id)
        : await _userProfileUseCase.getAuthenticatedUserProfile(event.userId!);

    if (profile == null) {
      emit(UserProfileLoadFailState());
      return;
    }

    emit(UserProfileLoadedState(profile: profile));
  }
}
