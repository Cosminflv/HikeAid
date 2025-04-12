import 'package:shared/domain/coordinates_entity.dart';
import 'package:domain/entities/navigation_instruction_entity.dart';
import 'package:domain/entities/route_entity.dart';
import 'package:domain/entities/trip_entity.dart';
import 'package:domain/repositories/navigation_repository.dart';

import 'package:equatable/equatable.dart';

enum EVisibleDialog { cancel, arrival, summary, none }

class NavigationViewState extends Equatable {
  final NavigationStatus status;

  final RouteEntity? route;
  final TripEntity? trip;

  final NavigationInstructionEntity? currentInstruction;

  final int traveledDistance;
  final DateTime? startNavigationTimeStamp;
  final DateTime? endNavigationTimeStamp;

  final bool areVoiceInstructionsEnabled;

  final EVisibleDialog shownDialog;

  final bool isSimulated;
  final bool isNavigatingOnTour;

  final List<CoordinatesEntity> previousCoordinates;

  const NavigationViewState({
    this.status = NavigationStatus.stopped,
    this.route,
    this.trip,
    this.areVoiceInstructionsEnabled = true,
    this.currentInstruction,
    this.traveledDistance = 0,
    this.startNavigationTimeStamp,
    this.endNavigationTimeStamp,
    this.shownDialog = EVisibleDialog.none,
    this.isSimulated = false,
    this.isNavigatingOnTour = false,
    this.previousCoordinates = const [],
  });

  NavigationViewState copyWith(
      {NavigationStatus? status,
      RouteEntity? route,
      TripEntity? trip,
      NavigationInstructionEntity? currentInstruction,
      int? traveledDistance,
      DateTime? startNavigationTimeStamp,
      DateTime? endNavigationTimeStamp,
      bool? areVoiceInstructionsEnabled,
      EVisibleDialog? shownDialog,
      double? averageSpeed,
      bool? isSimulated,
      bool? isNavigatingOnTour,
      List<CoordinatesEntity>? previousCoordinates}) {
    return NavigationViewState(
      status: status ?? this.status,
      route: route ?? this.route,
      trip: trip ?? this.trip,
      currentInstruction: currentInstruction ?? this.currentInstruction,
      traveledDistance: traveledDistance ?? this.traveledDistance,
      startNavigationTimeStamp: startNavigationTimeStamp ?? this.startNavigationTimeStamp,
      endNavigationTimeStamp: endNavigationTimeStamp ?? this.endNavigationTimeStamp,
      areVoiceInstructionsEnabled: areVoiceInstructionsEnabled ?? this.areVoiceInstructionsEnabled,
      shownDialog: shownDialog ?? this.shownDialog,
      isSimulated: isSimulated ?? this.isSimulated,
      isNavigatingOnTour: isNavigatingOnTour ?? this.isNavigatingOnTour,
      previousCoordinates: previousCoordinates ?? this.previousCoordinates,
    );
  }

  NavigationViewState copyWithNullRoute() => NavigationViewState(
        status: status,
        route: null,
        trip: trip,
        currentInstruction: currentInstruction,
        areVoiceInstructionsEnabled: areVoiceInstructionsEnabled,
        traveledDistance: traveledDistance,
        shownDialog: shownDialog,
        startNavigationTimeStamp: startNavigationTimeStamp,
        endNavigationTimeStamp: endNavigationTimeStamp,
        isSimulated: isSimulated,
        isNavigatingOnTour: isNavigatingOnTour,
        previousCoordinates: previousCoordinates,
      );

  NavigationViewState copyWithNullTrip() => NavigationViewState(
        status: status,
        route: route,
        trip: null,
        currentInstruction: currentInstruction,
        areVoiceInstructionsEnabled: areVoiceInstructionsEnabled,
        traveledDistance: traveledDistance,
        shownDialog: shownDialog,
        startNavigationTimeStamp: startNavigationTimeStamp,
        endNavigationTimeStamp: endNavigationTimeStamp,
        isSimulated: isSimulated,
        isNavigatingOnTour: isNavigatingOnTour,
        previousCoordinates: previousCoordinates,
      );

  NavigationViewState copyWithNullInstruction() => NavigationViewState(
        status: status,
        route: route,
        trip: trip,
        currentInstruction: null,
        areVoiceInstructionsEnabled: areVoiceInstructionsEnabled,
        traveledDistance: traveledDistance,
        shownDialog: shownDialog,
        startNavigationTimeStamp: startNavigationTimeStamp,
        endNavigationTimeStamp: endNavigationTimeStamp,
        isSimulated: isSimulated,
        isNavigatingOnTour: isNavigatingOnTour,
        previousCoordinates: previousCoordinates,
      );

  bool get hasInstruction => currentInstruction != null;

  @override
  List<Object?> get props => [
        areVoiceInstructionsEnabled,
        currentInstruction,
        traveledDistance,
        status,
        route,
        trip,
        shownDialog,
        startNavigationTimeStamp,
        endNavigationTimeStamp,
        isSimulated,
        isNavigatingOnTour,
        previousCoordinates
      ];
}
