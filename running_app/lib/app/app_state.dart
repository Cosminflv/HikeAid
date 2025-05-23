import 'package:domain/settings/general_settings_entity.dart';
import 'package:equatable/equatable.dart';

enum AppStatus {
  uninitialized,
  intializedSDK,
  initializedMap,
  drawing,
  routing,
  navigation,
  navigationPaused,
  recording,
  recordingPaused
}

enum AppBrightness { dark, light }

class AppState extends Equatable {
  final AppStatus status;
  final DDistanceUnit distanceUnit;
  final DSpeedUnit speedUnit;
  final AppBrightness statusBarBrightness;

  const AppState(
      {this.status = AppStatus.uninitialized,
      this.distanceUnit = DDistanceUnit.km,
      this.speedUnit = DSpeedUnit.kmPerHour,
      this.statusBarBrightness = AppBrightness.light});

  AppState copyWith({AppStatus? status, DDistanceUnit? distanceUnit, AppBrightness? statusBarBrightness}) => AppState(
      status: status ?? this.status,
      distanceUnit: distanceUnit ?? this.distanceUnit,
      statusBarBrightness: statusBarBrightness ?? this.statusBarBrightness);

  bool get isNavigating => status == AppStatus.navigation;

  bool get isRecording => status == AppStatus.recording;
  bool get isRecordingPaused => status == AppStatus.recordingPaused;

  bool get isDrawing => status == AppStatus.drawing;

  @override
  List<Object?> get props => [status, distanceUnit];
}
