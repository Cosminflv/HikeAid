import 'package:domain/repositories/sdk_settings_repository.dart';
import 'package:domain/settings/general_settings_entity.dart';
import 'package:gem_kit/core.dart';

class SDKSettingsRepositoryImpl implements SDKSettingsRepository {
  @override
  void setDistanceUnitType(DDistanceUnit unit) => SdkSettings.unitSystem = UnitSystem.values[unit.index];

  @override
  void setMapLabelsLanguage(DMapLabelsLanguage language) =>
      SdkSettings.mapLanguage = MapLanguage.values[language.index];

  @override
  void setAllowMobileData(bool allow) =>
      SdkSettings.setAllowOffboardServiceOnExtraChargedNetwork(ServiceGroupType.contentService, allow);
}
