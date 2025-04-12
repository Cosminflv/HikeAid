import 'package:domain/entities/friendship_entity.dart';
import 'package:domain/entities/search_user_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_page.dart';
import 'package:running_app/friendships/friendships_view_page.dart';
import 'package:running_app/home/home_view_page.dart';
import 'package:running_app/map/map_view_page.dart';
import 'package:running_app/map/widgets/ask_permission_popup.dart';
import 'package:running_app/onboarding/authentication/authentication_page.dart';
import 'package:running_app/onboarding/get_started_page.dart';
import 'package:running_app/onboarding/registration/registration_page.dart';
import 'package:running_app/onboarding/user_preferences_setup/user_preferences_wizard_page.dart';
import 'package:running_app/search/search_history/search_history_view_page.dart';
import 'package:running_app/search/search_view_page.dart';
import 'package:running_app/search_users/search_users_view_page.dart';
import 'package:running_app/tour_recording/tour_recording_finished_page.dart';
import 'package:running_app/user_profile/user_profile_view_page.dart';
import 'package:shared/domain/user_profile_entity.dart';

class RouteNames {
  @pragma('Startup')
  static const defaultPage = '';
  static const getStartedPage = '$defaultPage/get_started_page';

  @pragma('Onboarding')
  static const authenticationPage = '$defaultPage/authentication_page';
  static const registrationPage = '$defaultPage/registration_page';

  @pragma('Maps & Navigation')
  static const mapPage = '$defaultPage/map_page';
  static const askPermissionPage = '$defaultPage/ask_permission_popup';
  static const searchPage = '$defaultPage/search_view_page';
  static const searchHistoryPage = '$defaultPage/search_history_page';
  static const tourFinished = '$mapPage/tour_finished';

  @pragma('Personal')
  static const editProfilePage = '$defaultPage/edit_user_profile_view_page';
  static const searchUsersPage = '$defaultPage/search_users_view_page';
  static const userProfilePage = '$defaultPage/user_profile_view_page';
  static const userPreferencesWizardPage = '$defaultPage/user_preferences_wizard_page';
  static const friendshipRequests = '$defaultPage/friendships_view_page';

  @pragma('MISC')
  static const homePage = '${defaultPage}home_page';
}

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  Widget? page;
  switch (settings.name) {
    // Startup

    case RouteNames.getStartedPage:
      page = const GetStartedPage();

    //Onboarding
    case RouteNames.authenticationPage:
      page = const AuthenticationPage();
    case RouteNames.registrationPage:
      page = const RegistrationPage();

    // Maps & Navigation
    case RouteNames.mapPage:
      page = const MapViewPage();
    case RouteNames.askPermissionPage:
      return FadeRoute(page: const AskPermissionPopup());
    case RouteNames.searchPage:
      return FadeRoute(page: SearchViewPage());
    case RouteNames.searchHistoryPage:
      return FadeRoute(page: const SearchHistoryViewPage());
    case RouteNames.tourFinished:
      page = const TourRecordingFinishedPage();

    // Personal
    case RouteNames.editProfilePage:
      final profile = settings.arguments as UserProfileEntity;
      page = EditUserProfileViewPage(profile: profile);
    case RouteNames.searchUsersPage:
      page = SearchUsersViewPage();
    case RouteNames.userProfilePage:
      final args = settings.arguments as Map<String, dynamic>;
      final isEditable = args['isEditable'] as bool;
      page = UserProfileViewPage(
        isEditable: isEditable,
        friendshipStatus: args.containsKey('friendshipStatus') ? args['friendshipStatus'] as FriendshipStatus : null,
        friendRequest: args.containsKey('friendRequest') ? args['friendRequest'] as FriendshipEntity : null,
      );
    case RouteNames.userPreferencesWizardPage:
      page = const UserPreferencesWizardPage();
    case RouteNames.friendshipRequests:
      page = const FriendshipsViewPage();

    // MISC
    case RouteNames.homePage:
      page = const HomeViewPage();
  }

  return page != null ? PageTransition(child: page, type: PageTransitionType.leftToRight) : null;
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
