import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:running_app/onboarding/authentication/authentication_page.dart';
import 'package:running_app/onboarding/get_started_page.dart';
import 'package:running_app/onboarding/onboarding_menu_page.dart';
import 'package:running_app/onboarding/registration_page.dart';

class RouteNames {
  @pragma('Startup')
  static const defaultPage = '';
  static const getStartedPage = '$defaultPage/get_started_page';

  @pragma('Onboarding')
  static const onboardingMenuPage = '$defaultPage/onboarding_menu_page';
  static const authenticationPage = '$defaultPage/authentication_page';
  static const registrationPage = '$defaultPage/registration_page';
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
    case RouteNames.onboardingMenuPage:
      page = const OnboardingMenuPage();
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
