import 'dart:ui';

import 'package:data/models/task_progress_listener_impl.dart';
import 'package:data/repositories_impl/extensions.dart';
import 'package:data/utils/image_cache.dart';
import 'package:domain/entities/landmark_with_distance_entity.dart';
import 'package:domain/repositories/search_repository.dart';
import 'package:domain/repositories/task_progress_listener.dart';
import 'package:gem_kit/search.dart';
import 'package:gem_kit/core.dart';

import 'package:dartz/dartz.dart';
import 'package:shared/domain/coordinates_entity.dart';
import 'package:shared/extensions.dart';

class SearchRepositoryImpl extends SearchRepository {
  @override
  TaskProgressListener search(
      {required String text, required CoordinatesEntity coordinates, required Function(SearchResult) onResult}) {
    var progress = TaskProgressListenerImpl();

    progress.ref = SearchService.search(text, coordinates.toGemCoordinates(), (err, result) {
      if (err != GemError.success) {
        onResult(Left(err.code));
        return;
      }

      if (progress.shouldCancel) {
        return;
      }

      final imageCache = ImageCache();
      final width = 48, height = 48;

      final landmarkEntities = <LandmarkWithDistanceEntity>[];

      for (final lmk in result) {
        if (progress.shouldCancel) {
          return;
        }

        final imageUid = lmk.imageUid;

        var image = imageCache.get(imageUid);

        if (image == null) {
          image = lmk.getImage(size: Size(128, 128), format: ImageFileFormat.png);
          imageCache.add(imageUid, image!);
        }
        final lmkEntity = lmk.toEntityImpl(width: width, height: height, image: image);

        landmarkEntities.add(LandmarkWithDistanceEntity(lmkEntity, coordinates));
      }

      onResult(Right(landmarkEntities));
    });
    return progress;
  }

  @override
  void cancelSearch(TaskProgressListener listener) {
    final listenerImpl = listener as TaskProgressListenerImpl;

    listenerImpl.shouldCancel = true;
    SearchService.cancelSearch(listener.ref!);
  }

  @override
  void cancelAddressSearch(TaskProgressListener listener) {
    final listenerImpl = listener as TaskProgressListenerImpl;
    listenerImpl.shouldCancel = true;
    GuidedAddressSearchService.cancelSearch(listener.ref!);
  }
}
