import 'package:core/di/injection_container.dart';
import 'package:domain/use_cases/user_profile_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/view_user_profile/view_user_profile_view_event.dart';
import 'package:running_app/view_user_profile/view_user_profile_view_state.dart';

class ViewUserProfileViewBloc extends Bloc<ViewUserProfileViewEvent, ViewUserProfileViewState> {
  final _userProfileUseCase = sl.get<UserProfileUseCase>();

  ViewUserProfileViewBloc() : super(InitialProfileState()) {
    on<FetchUserProfileEvent>(_handleFetchUserProfile);
  }

  _handleFetchUserProfile(FetchUserProfileEvent event, Emitter<ViewUserProfileViewState> emit) async {
    emit(UserProfileLoadingState());

    final profile = await _userProfileUseCase.getAuthenticatedUserProfile(event.userId);

    if (profile == null) {
      emit(UserProfileLoadFailState());
      return;
    }

    emit(UserProfileLoadedState(profile: profile));
  }
}
