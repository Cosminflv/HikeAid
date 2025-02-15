import 'package:data/gen/assets.gen.dart';
import 'package:data/models/local_map_style_entity_impl.dart';
import 'package:data/utils/assets_utils.dart';
import 'package:domain/entities/local_map_style_entity.dart';
import 'package:domain/repositories/content_store_repository.dart';

class ContentStoreRepositoryImpl extends ContentStoreRepository {
  @override
  Future<List<LocalMapStyleEntity>> getAvailableLocalStyles() async {
    return [
      LocalMapStyleEntityImpl(
        path: await copyAssetStyleToSceneRes(Assets.mapStyles.styles.cycleMobile),
        previewPath: Assets.mapStyles.previews.cyclePreview.path,
        style: MapStyles.cycle,
        hasElevation: false,
      ),
      LocalMapStyleEntityImpl(
        path: await copyAssetStyleToSceneRes(Assets.mapStyles.styles.cycleSatellite1Mobile),
        previewPath: Assets.mapStyles.previews.cycleSatellite1Preview.path,
        style: MapStyles.satellite,
        hasElevation: false,
      ),
      LocalMapStyleEntityImpl(
          path: await copyAssetStyleToSceneRes(Assets.mapStyles.styles.cycleSatellite1WithElevationMobile),
          previewPath: Assets.mapStyles.previews.cycleSatellite1WithElevationPreview.path,
          style: MapStyles.satelliteElevated,
          hasElevation: true),
      LocalMapStyleEntityImpl(
        path: await copyAssetStyleToSceneRes(Assets.mapStyles.styles.cycleWithElevationMobile),
        previewPath: Assets.mapStyles.previews.cycleWithElevationPreview.path,
        style: MapStyles.elevation,
        hasElevation: true,
      ),
      LocalMapStyleEntityImpl(
        path: await copyAssetStyleToSceneRes(Assets.mapStyles.styles.magicDayMobile),
        previewPath: Assets.mapStyles.previews.magicDayPreview.path,
        style: MapStyles.magicDay,
        hasElevation: false,
      ),
      LocalMapStyleEntityImpl(
        path: await copyAssetStyleToSceneRes(Assets.mapStyles.styles.magicNightMobile),
        previewPath: Assets.mapStyles.previews.magicNightPreview.path,
        style: MapStyles.magicNight,
        hasElevation: false,
      ),
    ];
  }
}
