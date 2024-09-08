import 'package:domain/settings/general_settings_entity.dart';

abstract class SDKSettingsRepository {
  void setMapLabelsLanguage(DMapLabelsLanguage language);
  void setDistanceUnitType(DDistanceUnit unit);
  void setAllowMobileData(bool allow);
}
