import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/app/app_bloc.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_bloc.dart';
import 'package:running_app/location/location_bloc.dart';
import 'package:running_app/map/map_view_bloc.dart';
import 'package:running_app/onboarding/auth_session/auth_session_bloc.dart';
import 'package:running_app/onboarding/authentication/authentication_view_bloc.dart';
import 'package:running_app/onboarding/registration/registration_view_bloc.dart';
import 'package:running_app/search_users/search_users_view_bloc.dart';
import 'package:running_app/user_profile/user_profile_view_bloc.dart';

class BlocProviders {
  static AuthenticationViewBloc authentication(BuildContext context) =>
      BlocProvider.of<AuthenticationViewBloc>(context);

  static RegistrationViewBloc registration(BuildContext context) => BlocProvider.of<RegistrationViewBloc>(context);
  static AuthSessionBloc authSession(BuildContext context) => BlocProvider.of<AuthSessionBloc>(context);

  static EditUserProfileViewBloc editProfile(BuildContext context) => BlocProvider.of<EditUserProfileViewBloc>(context);
  static UserProfileBloc userProfile(BuildContext context) => BlocProvider.of<UserProfileBloc>(context);
  static SearchUsersBloc searchUsers(BuildContext context) => BlocProvider.of<SearchUsersBloc>(context);

  static MapViewBloc map(BuildContext context) => BlocProvider.of<MapViewBloc>(context);
  static LocationBloc location(BuildContext context) => BlocProvider.of<LocationBloc>(context);
  static AppBloc app(BuildContext context) => BlocProvider.of<AppBloc>(context);
}
