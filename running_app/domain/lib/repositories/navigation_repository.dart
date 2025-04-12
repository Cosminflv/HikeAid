import 'package:domain/entities/navigation_instruction_entity.dart';
import 'package:domain/entities/route_entity.dart';
import 'package:domain/repositories/task_progress_listener.dart';
import 'package:shared/domain/landmark_entity.dart';

enum NavigationStatus { started, stopped, finished, paused, restarting }

abstract class NavigationRepository {
  // Navigation Control
  TaskProgressListener startNavigation(RouteEntity route,
      {required Function(NavigationInstructionEntity) onInstructionUpdated,
      required Function(String) onVoiceInstructionUpdated,
      required Function(RouteEntity) onRouteUpdated,
      required Function(LandmarkEntity) onWaypointReached,
      required Function() onDestinationReached,
      bool isSimulated = false,
      double? demoSpeed});

  void stopNavigation(TaskProgressListener listener);

  void setNavigationRoadBlock(
      {required TaskProgressListener progressListener, required int length, int? startDistance});
}
