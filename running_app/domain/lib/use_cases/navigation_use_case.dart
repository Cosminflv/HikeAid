import 'package:domain/entities/landmark_entity.dart';
import 'package:domain/entities/navigation_instruction_entity.dart';
import 'package:domain/entities/route_entity.dart';
import 'package:domain/repositories/navigation_repository.dart';
import 'package:domain/repositories/task_progress_listener.dart';
import 'package:domain/repositories/tts_repository.dart';

class NavigationUseCase {
  final NavigationRepository _navigationRepository;
  final TTSRepository _ttsRepository;

  TaskProgressListener? _navigationProgressListener;

  NavigationUseCase(this._navigationRepository, this._ttsRepository);

  startNavigation(
      {required RouteEntity route,
      required Function(NavigationInstructionEntity) onInstructionUpdated,
      required Function(RouteEntity) onRouteUpdated,
      required Function(LandmarkEntity) onWaypointReached,
      required Function() onDestinationReached,
      bool isSimulated = false,
      double? demoSpeed}) {
    _navigationProgressListener = _navigationRepository.startNavigation(
      route,
      onInstructionUpdated: onInstructionUpdated,
      onDestinationReached: onDestinationReached,
      onRouteUpdated: onRouteUpdated,
      onWaypointReached: onWaypointReached,
      onVoiceInstructionUpdated: (ins) => _ttsRepository.speakText(ins),
      demoSpeed: demoSpeed,
      isSimulated: isSimulated,
    );
  }

  stopNavigation() {
    if (_navigationProgressListener != null) {
      _navigationRepository.stopNavigation(_navigationProgressListener!);
      _navigationProgressListener = null;
    }
  }

  void setNavigationRoadBlock({required int length, int? startDistance}) {
    if (_navigationProgressListener == null) return;

    _navigationRepository.setNavigationRoadBlock(
        progressListener: _navigationProgressListener!, length: length, startDistance: startDistance);
  }

  Future<void> setVoiceInstructionVolume(double volume) async => await _ttsRepository.setVolume(volume);
}
