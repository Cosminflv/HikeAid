import 'package:equatable/equatable.dart';
import 'package:shared/domain/position_entity.dart';

class LocationState extends Equatable {
  final bool isLocationEnabled;
  final bool hasLocationPermission;

  final PositionEntity? currentPosition;

  final bool openLocationPanel;

  bool get hasFullLocation => isLocationEnabled && hasLocationPermission && currentPosition != null;
  bool get isFollowPositionEnabled => currentPosition != null || !isLocationEnabled || !hasLocationPermission;

  const LocationState({
    this.isLocationEnabled = false,
    this.hasLocationPermission = false,
    this.openLocationPanel = false,
    this.currentPosition,
  });

  LocationState copyWith({
    bool? isLocationEnabled,
    bool? hasLocationPermission,
    bool? openLocationPanel,
    PositionEntity? currentPosition,
  }) =>
      LocationState(
        isLocationEnabled: isLocationEnabled ?? this.isLocationEnabled,
        hasLocationPermission: hasLocationPermission ?? this.hasLocationPermission,
        openLocationPanel: openLocationPanel ?? this.openLocationPanel,
        currentPosition: currentPosition ?? this.currentPosition,
      );

  LocationState copyWithNullPosition() => LocationState(
        isLocationEnabled: isLocationEnabled,
        hasLocationPermission: hasLocationPermission,
        openLocationPanel: openLocationPanel,
        currentPosition: null,
      );

  @override
  List<Object?> get props => [
        isLocationEnabled,
        hasLocationPermission,
        openLocationPanel,
        currentPosition,
      ];
}
