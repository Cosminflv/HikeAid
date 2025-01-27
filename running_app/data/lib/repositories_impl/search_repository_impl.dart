import 'package:data/extensions.dart';
import 'package:data/models/landmark_category_entity_impl.dart';
import 'package:data/models/task_progress_listener_impl.dart';
import 'package:data/utils/image_cache.dart';
import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/entities/landmark_category_entity.dart';
import 'package:domain/entities/landmark_with_distance_entity.dart';
import 'package:domain/repositories/search_repository.dart';
import 'package:domain/repositories/task_progress_listener.dart';
import 'package:gem_kit/search.dart';
import 'package:gem_kit/core.dart';

import 'package:dartz/dartz.dart';

class SearchRepositoryImpl extends SearchRepository {
  @override
  TaskProgressListener search(
      {required String text, required CoordinatesEntity coordinates, required Function(SearchResult) onResult}) {
    var progress = TaskProgressListenerImpl();

    progress.ref = SearchService.search(text, coordinates.toGemCoordinates(), (err, result) {
      if (err != GemError.success || result == null) {
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
          image = lmk.getImage();
          imageCache.add(imageUid, image);
        }
        final lmkEntity = lmk.toEntityImpl(width: width, height: height, image: image);

        landmarkEntities.add(LandmarkWithDistanceEntity(lmkEntity, coordinates));
      }

      onResult(Right(landmarkEntities));
    });
    return progress;
  }

  @override
  TaskProgressListener searchWithCategory(
      {required LandmarkCategoryEntity category,
      required CoordinatesEntity coordinates,
      required Function(SearchResult) onResult}) {
    category as LandmarkCategoryEntityImpl;

    final progress = TaskProgressListenerImpl();

    final prefs = SearchPreferences(searchAddresses: false, searchMapPOIs: true, maxMatches: 40);
    prefs.landmarks.addStoreCategoryId(category.ref.landmarkStoreId, category.ref.id);

    progress.ref =
        SearchService.searchAroundPosition(coordinates.toGemCoordinates(), preferences: prefs, (err, result) {
      if (err != GemError.success || result == null) {
        onResult(Left(err.code));
        return;
      }

      if (progress.shouldCancel) return;

      final imageCache = ImageCache();
      final width = 48, height = 48;

      final landmarkEntities = <LandmarkWithDistanceEntity>[];

      for (final lmk in result) {
        if (progress.shouldCancel) return;

        final imageUid = lmk.imageUid;

        var image = imageCache.get(imageUid);

        if (image == null) {
          image = lmk.getImage();
          imageCache.add(imageUid, image);
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
