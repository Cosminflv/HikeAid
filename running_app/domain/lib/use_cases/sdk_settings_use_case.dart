import 'package:domain/repositories/sdk_settings_repository.dart';
import 'package:domain/settings/general_settings_entity.dart';

class SDKSettingsUseCase {
  final SDKSettingsRepository _repository;

  SDKSettingsUseCase(this._repository);

  void setMapLabelsLanguage(DMapLabelsLanguage language) => _repository.setMapLabelsLanguage(language);

  void setDistanceUnitType(DDistanceUnit unit) => _repository.setDistanceUnitType(unit);

  void setAllowMobileData(bool allow) => _repository.setAllowMobileData(allow);
}
