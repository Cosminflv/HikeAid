import 'package:data/models/route_entity_impl.dart';
import 'package:data/models/task_progress_listener_impl.dart';
import 'package:data/repositories_impl/extensions.dart';

import 'package:domain/entities/landmark_entity.dart';
import 'package:domain/entities/navigation_instruction_entity.dart';
import 'package:domain/entities/route_entity.dart';
import 'package:domain/repositories/image_cache_repository.dart';
import 'package:domain/repositories/navigation_repository.dart';
import 'package:domain/repositories/task_progress_listener.dart';

import 'package:gem_kit/navigation.dart';

class NavigationRepositoryImpl extends NavigationRepository {
  final ImageCacheRepository _imageCacheRepository;

  NavigationRepositoryImpl(
    this._imageCacheRepository,
  );
// Navigation Control
  @override
  TaskProgressListener startNavigation(RouteEntity route,
      {required Function(NavigationInstructionEntity) onInstructionUpdated,
      required Function(String) onVoiceInstructionUpdated,
      required Function(RouteEntity) onRouteUpdated,
      required Function(LandmarkEntity) onWaypointReached,
      required Function() onDestinationReached,
      bool isSimulated = false,
      double? demoSpeed}) {
    route as RouteEntityImpl;

    var progress = TaskProgressListenerImpl();

    if (isSimulated) {
      progress.ref = NavigationService.startSimulation(
          route.ref, (type, ins) => _navigationEventsHandler(type, ins, onInstructionUpdated, onDestinationReached),
          onTextToSpeechInstruction: onVoiceInstructionUpdated, onRouteUpdated: (updatedRoute) {
        final routeEntity = updatedRoute.toEntityImpl(waypoints: []);
        onRouteUpdated(routeEntity);
      }, speedMultiplier: demoSpeed);
    } else {
      progress.ref = NavigationService.startNavigation(
        route.ref,
        (type, ins) => _navigationEventsHandler(type, ins, onInstructionUpdated, onDestinationReached),
        onTextToSpeechInstruction: onVoiceInstructionUpdated,
        onRouteUpdated: (updatedRoute) {
          final routeEntity = updatedRoute.toEntityImpl(waypoints: []);
          onRouteUpdated(routeEntity);
        },
      );
    }

    return progress;
  }

  @override
  void stopNavigation(TaskProgressListener listener) {
    listener as TaskProgressListenerImpl;

    NavigationService.cancelNavigation(listener.ref!);
  }

  _navigationEventsHandler(NavigationEventType type, NavigationInstruction? ins,
      Function(NavigationInstructionEntity) onInstructionUpdated, Function() onDestinationReached) {
    switch (type) {
      case NavigationEventType.error:
        break;
      case NavigationEventType.destinationReached:
        onDestinationReached();
        break;
      case NavigationEventType.navigationInstructionUpdate:
        if (ins == null) return;
        final imageUid = ins.nextTurnDetails.abstractGeometryImageUid;
        final cachedImage = _imageCacheRepository.getNavigationInstructionImageByUid(imageUid);

        final insEntityImpl = ins.toEntityImpl(imageUid: imageUid, image: cachedImage);

        if (cachedImage == null) {
          _imageCacheRepository.setNavigationInstructionImage(imageUid, insEntityImpl.image);
        }
        onInstructionUpdated(insEntityImpl);
        break;
    }
  }

  @override
  void setNavigationRoadBlock(
      {required TaskProgressListener progressListener, required int length, int? startDistance}) {
    progressListener as TaskProgressListenerImpl;

    NavigationService.setNavigationRoadBlock(length, startDistance: startDistance, taskHandler: progressListener.ref);
  }
}
