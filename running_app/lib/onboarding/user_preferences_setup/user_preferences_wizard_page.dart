import 'package:core/di/injection_container.dart';
import 'package:shared/domain/user_profile_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:running_app/config/routes.dart';
import 'package:running_app/config/theme.dart';
import 'package:running_app/onboarding/registration/registration_view_bloc.dart';
import 'package:running_app/onboarding/registration/registration_view_event.dart';
import 'package:running_app/onboarding/registration/registration_view_state.dart';
import 'package:running_app/onboarding/user_preferences_setup/user_preferences_birthdate_page.dart';
import 'package:running_app/onboarding/user_preferences_setup/user_preferences_gender_page.dart';
import 'package:running_app/onboarding/user_preferences_setup/user_preferences_location_page.dart';
import 'package:running_app/onboarding/user_preferences_setup/user_preferences_setup_complete_page.dart';
import 'package:running_app/onboarding/user_preferences_setup/user_preferences_start_page.dart';
import 'package:running_app/onboarding/user_preferences_setup/user_preferences_weight_page.dart';
import 'package:running_app/shared_widgets/custom_text_button.dart';
import 'package:running_app/utils/toasts.dart';
import 'package:dots_indicator/dots_indicator.dart';

class UserPreferencesWizardPage extends StatefulWidget {
  const UserPreferencesWizardPage({super.key});

  @override
  State<StatefulWidget> createState() => _UserPreferencesWizzardPageState();
}

class _UserPreferencesWizzardPageState extends State<UserPreferencesWizardPage> {
  final _stepsCount = 6;
  final _pageController = PageController();
  final _bloc = sl.get<RegistrationViewBloc>();

  int _currentStep = 0;
  EGenderEntity _currentGender = EGenderEntity.man;
  String _currentCity = "";
  String _currentCountry = "";
  DateTime _currentBirthDate = DateTime.now();
  int _currentWeight = 75;

  bool _areLocationFieldsValid() {
    return _currentCity.isNotEmpty && _currentCountry.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationViewBloc, RegistrationViewState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is RegistrationSuccesfulState) {
          Navigator.of(context).pushReplacementNamed(RouteNames.authenticationPage);
        }
        if (state is RegistrationFailedState) {
          showErrorToast(state.reason.name);
        }
      },
      builder: (context, state) {
        return PlatformScaffold(
          backgroundColor: getThemedItemBackgroundColor(context),
          body: Material(
            type: MaterialType.transparency,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          onPageChanged: (index) => setState(
                            () {
                              _currentStep = index;
                            },
                          ),
                          children: [
                            const UserPreferencesStartPage(),
                            UserLocationPage(
                              initialCity: _currentCity,
                              initialCountry: _currentCountry,
                              onCityValueChanged: (val) => setState(
                                () {
                                  _currentCity = val;
                                },
                              ),
                              onCountryValueChanged: (val) => setState(() {
                                _currentCountry = val;
                              }),
                            ),
                            UserWeightPage(
                              initialWeight: _currentWeight,
                              onChanged: (val) => setState(() {
                                _currentWeight = val;
                              }),
                            ),
                            UserGenderPage(
                              initialGender: _currentGender,
                              onGenderChanged: (val) => setState(() {
                                _currentGender = val;
                              }),
                            ),
                            UserBirthdatePage(
                              initialBirthdate: _currentBirthDate,
                              onBirthdateChanged: (value) => setState(() {
                                _currentBirthDate = value;
                              }),
                            ),
                            const UserSetupCompletePage(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: DotsIndicator(
                          position: _currentStep,
                          dotsCount: _stepsCount,
                          decorator:
                              DotsDecorator(activeColor: Theme.of(context).colorScheme.primary, color: Colors.grey),
                        ),
                      ),
                      Row(
                        children: [
                          if (_currentStep != 0)
                            SizedBox(
                              width: 50,
                              child: CustomElevatedButton(
                                backgroundColor: Colors.blue,
                                onTap: () {
                                  _onPageChange(_currentStep - 1);
                                  FocusScope.of(context).unfocus();
                                },
                                alignment: MainAxisAlignment.center,
                                leading: const Icon(
                                  CupertinoIcons.chevron_left,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          if (_currentStep != 0) const SizedBox(width: 10),
                          Expanded(
                            child: CustomElevatedButton(
                                alignment: MainAxisAlignment.center,
                                text: _getStepButtonText(_currentStep),
                                textColor: Colors.white,
                                onTap: () {
                                  _onPageChange(_currentStep + 1);
                                  FocusScope.of(context).unfocus();
                                },
                                backgroundColor: Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _onPageChange(int newIndex) {
    if (!_areLocationFieldsValid() && newIndex == 2) return;

    if (newIndex == _stepsCount) {
      _bloc.add(PerformRegistrationEvent(birthdate: _currentBirthDate));
      return;
    }
    if (newIndex == _stepsCount - 1) {
      _bloc.add(CompleteUserProfileEvent(
          city: _currentCity,
          country: _currentCountry,
          birthDate: _currentBirthDate,
          gender: _currentGender,
          weight: _currentWeight));
    }

    _pageController.animateToPage(newIndex, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);

    setState(() => _currentStep = newIndex);
  }

  String _getStepButtonText(int currentStep) {
    switch (currentStep) {
      case 0:
        return "Let's start";
      case 4:
        return 'Finish';
      case 5:
        return 'Proceed to login';
      default:
        return 'Next';
    }
  }
}
