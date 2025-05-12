import 'package:domain/entities/landmark_store_entity.dart';
import 'package:running_app/app/app_bloc.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_bloc.dart';
import 'package:running_app/friendships/friendships_view_bloc.dart';
import 'package:running_app/internet_connection/device_info_bloc.dart';
import 'package:running_app/location/location_bloc.dart';
import 'package:running_app/landmark_store/landmark_store_bloc.dart';

import 'package:core/di/injection_container.dart';
import 'package:running_app/map/map_view_bloc.dart';
import 'package:running_app/navigation/navigation_view_bloc.dart';
import 'package:running_app/onboarding/auth_session/auth_session_bloc.dart';
import 'package:running_app/onboarding/authentication/authentication_view_bloc.dart';
import 'package:running_app/onboarding/registration/registration_view_bloc.dart';
import 'package:running_app/position_prediction/position_prediction_bloc.dart';
import 'package:running_app/routing/routing_view_bloc.dart';
import 'package:running_app/search/search_menu_bloc.dart';
import 'package:running_app/search_users/search_users_view_bloc.dart';
import 'package:running_app/settings/settings_view_bloc.dart';
import 'package:running_app/user_profile/user_profile_view_bloc.dart';
import 'package:running_app/home/home_view_bloc.dart';
import 'package:running_app/navigation_instructions/navigation_instructions_panel_bloc.dart';
import 'package:running_app/tour_recording/tour_recording_bloc.dart';
import 'package:running_app/alerts/alert_bloc.dart';
import 'package:running_app/map_styles/map_styles_panel_bloc.dart';
import 'package:running_app/settings/content_store_view/content_store_bloc.dart';

class AppBlocs {
  // Existing Blocs

  // Getter for LocationBloc
  static LocationBloc get locationBloc => sl<LocationBloc>();

  // Getter for MapViewBloc
  static MapViewBloc get mapBloc => sl<MapViewBloc>();

  // Getter for RoutingViewBloc
  static RoutingViewBloc get routingBloc => sl<RoutingViewBloc>();

  // Getter for NavigationViewBloc
  static NavigationViewBloc get navigationBloc => sl<NavigationViewBloc>();

  // Getter for TourRecordingBloc
  static TourRecordingBloc get tourRecordingBloc => sl<TourRecordingBloc>();

  // Getter for LandmarkStoreBloc (searchHistory)
  static LandmarkStoreBloc get searchHistoryLandmarkStoreBloc =>
      sl<LandmarkStoreBloc>(instanceName: DLandmarkStoreType.searchHistory.name);

  // Getter for LandmarkStoreBloc (savedPlaces)
  static LandmarkStoreBloc get savedPlacesLandmarkStoreBloc =>
      sl<LandmarkStoreBloc>(instanceName: DLandmarkStoreType.savedPlaces.name);

  // Getter NavigationInstructionPanelBloc
  static NavigationInstructionPanelBloc get navigationInstructionBloc => sl<NavigationInstructionPanelBloc>();

  // Getter for LandmarkCategoryBloc
  //static LandmarkCategoryBloc get landmarkCategoryBloc => sl<LandmarkCategoryBloc>();

  // Getter for AppBloc
  static AppBloc get appBloc => sl<AppBloc>();

  // Getter for HomeViewBloc
  static HomeViewBloc get homeViewBloc => sl<HomeViewBloc>();

  // Getter for AuthSessionBloc
  static AuthSessionBloc get authSessionBloc => sl<AuthSessionBloc>();

  // Getter for AuthenticationViewBloc
  static AuthenticationViewBloc get authenticationViewBloc => sl<AuthenticationViewBloc>();

  // Getter for UserProfileViewBloc
  static UserProfileBloc get userProfileBloc => sl<UserProfileBloc>();

  // Getter for FriendshipsViewBloc
  static FriendshipsViewBloc get friendships => sl<FriendshipsViewBloc>();

  // Getter for InternetConnectionBloc
  static DeviceInfoBloc get deviceInfo => sl<DeviceInfoBloc>();

  // Getter for SearchMenuBloc
  static SearchMenuBloc get searchMenuBloc => sl<SearchMenuBloc>();

  // Getter for RegistrationViewBloc
  static RegistrationViewBloc get registrationViewBloc => sl<RegistrationViewBloc>();

  // Getter for EditUserProfileViewBloc
  static EditUserProfileViewBloc get editProfileBloc => sl<EditUserProfileViewBloc>();

  // Getter for SearchUsersBloc
  static SearchUsersBloc get searchUsersBloc => sl<SearchUsersBloc>();

  // Getter for AlertBloc
  static AlertBloc get alertBloc => sl<AlertBloc>();

  // Getter for MapStylesBloc
  static MapStylesPanelBloc get mapStylesBloc => sl<MapStylesPanelBloc>();

  // Getter for SettingsBloc
  static SettingsViewBloc get settingsViewBloc => sl.get<SettingsViewBloc>();

  // Getter for ContentStoreBloc
  static ContentStoreBloc get contentStore => sl<ContentStoreBloc>();

  // Getter for PositionPredictionBloc
  static PositionPredictionBloc get positionPredictionBloc => sl<PositionPredictionBloc>();
}
