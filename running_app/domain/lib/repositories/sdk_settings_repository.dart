import 'package:domain/settings/general_settings_entity.dart';

/// A repository interface for managing SDK settings.
///
/// This repository allows configuration of various SDK settings such as map labels language,
/// distance units, and mobile data usage preferences.
abstract class SDKSettingsRepository {
  /// Sets the language for map labels in the SDK.
  ///
  /// - Parameters:
  ///   - [language]: The desired language for map labels, represented by a [DMapLabelsLanguage].
  ///     Examples might include languages like English, French, or Spanish.
  /// - Throws:
  ///   - [SomeSpecificException] if setting the language fails.
  void setMapLabelsLanguage(DMapLabelsLanguage language);

  /// Sets the unit type for distance measurements in the SDK.
  ///
  /// - Parameters:
  ///   - [unit]: The desired unit type for distances, represented by a [DDistanceUnit].
  ///     Examples might include kilometers or miles.
  /// - Throws:
  ///   - [SomeSpecificException] if setting the unit type fails.
  void setDistanceUnitType(DDistanceUnit unit);

  /// Configures whether the SDK is allowed to use mobile data for operations.
  ///
  /// - Parameters:
  ///   - [allow]: A boolean value indicating whether to allow mobile data usage:
  ///     - `true` to allow mobile data usage.
  ///     - `false` to restrict SDK operations to Wi-Fi or offline data.
  /// - Throws:
  ///   - [SomeSpecificException] if setting the mobile data preference fails.
  void setAllowMobileData(bool allow);
}
