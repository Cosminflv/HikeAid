import 'package:core/di/injection_container.dart';
import 'package:domain/use_cases/user_profile_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/user_profile/user_profile_view_event.dart';
import 'package:running_app/user_profile/user_profile_view_state.dart';

class UserProfileViewBloc extends Bloc<UserProfileViewEvent, ViewUserProfileViewState> {
  final _userProfileUseCase = sl.get<UserProfileUseCase>();

  UserProfileViewBloc() : super(InitialProfileState()) {
    on<FetchUserProfileEvent>(_handleFetchUserProfile);
  }

  _handleFetchUserProfile(FetchUserProfileEvent event, Emitter<ViewUserProfileViewState> emit) async {
    emit(UserProfileLoadingState());

    if (event.session == null) {
      emit(UserProfileLoadFailState());
      return;
    }

    final profile = await _userProfileUseCase.getAuthenticatedUserProfile(event.session!.user.id);

    if (profile == null) {
      emit(UserProfileLoadFailState());
      return;
    }

    emit(UserProfileLoadedState(profile: profile));
  }
}
