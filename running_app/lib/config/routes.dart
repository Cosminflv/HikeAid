import 'package:domain/entities/user_profile_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_page.dart';
import 'package:running_app/home/home_view_page.dart';
import 'package:running_app/map/map_view_page.dart';
import 'package:running_app/map/widgets/ask_permission_popup.dart';
import 'package:running_app/onboarding/authentication/authentication_page.dart';
import 'package:running_app/onboarding/get_started_page.dart';
import 'package:running_app/onboarding/registration/registration_page.dart';
import 'package:running_app/search_users/search_users_view_page.dart';

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

  @pragma('Personal')
  static const editProfilePage = '$defaultPage/edit_user_profile_view_page';
  static const searchUsersPage = '$defaultPage/search_users_view_page';

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

    // Personal
    case RouteNames.editProfilePage:
      final profile = settings.arguments as UserProfileEntity;
      page = EditUserProfileViewPage(profile: profile);
    case RouteNames.searchUsersPage:
      page = SearchUsersViewPage();

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
