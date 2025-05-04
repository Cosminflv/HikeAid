import 'package:data/gen/assets.gen.dart';
import 'package:data/models/content_store_entity_impl.dart';
import 'package:data/models/content_store_item_entity_impl.dart';
import 'package:data/models/local_map_style_entity_impl.dart';
import 'package:data/models/country_entity_impl.dart';
import 'package:data/utils/assets_utils.dart';
import 'package:domain/entities/content_store_entity.dart';
import 'package:domain/entities/content_store_item_entity.dart';
import 'package:domain/entities/country_entity.dart';
import 'package:domain/entities/local_map_style_entity.dart';
import 'package:domain/repositories/content_store_repository.dart';
import 'package:domain/repositories/image_cache_repository.dart';
import 'package:gem_kit/content_store.dart';
import 'package:gem_kit/core.dart';
import 'package:gem_kit/map.dart';
import 'package:gem_kit/search.dart';

import 'package:flutter/services.dart';
import 'dart:async';

class ContentStoreRepositoryImpl extends ContentStoreRepository {
  final Map<(DContentStoreItemType, bool, DStyleColorTheme), ContentStoreEntityImpl> _contentStores = {};

  final ImageCacheRepository _imageCache;

  ContentUpdater? _contentUpdater;

  ContentStoreRepositoryImpl(this._imageCache);
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

  Future<bool> _shouldAutoUpdateIfNoLocalMaps() async {
    final boolCompleter = Completer<bool>();
    final localMapsContentStore = getContentStore(
      type: DContentStoreItemType.roadMap,
      isLocal: true,
      colorTheme: DStyleColorTheme.none,
    );

    localMapsContentStore.refresh();

    localMapsContentStore.onLoaded(
      onLoad: () {
        if (localMapsContentStore.items.isEmpty) {
          boolCompleter.complete(true);
        } else {
          boolCompleter.complete(false);
        }
      },
      persistAfterFail: true,
    );

    return boolCompleter.future;
  }

  @override
  Uint8List? getItemPreview(ContentStoreItemEntity item) {
    item as ContentStoreItemEntityImpl;
    final gemItem = item.ref;

    Uint8List? image;

    image = _imageCache.getCountryImage(gemItem.countryCodes[0]);

    return image;
  }

  @override
  ContentStoreEntity getContentStore({
    required DContentStoreItemType type,
    required bool isLocal,
    required DStyleColorTheme colorTheme,
  }) {
    final key = (type, isLocal, colorTheme);
    if (!_contentStores.containsKey(key)) {
      _contentStores[key] = ContentStoreEntityImpl(
        contentStoreItemType: type,
        isLocal: isLocal,
        colorTheme: colorTheme,
      );
    }

    return _contentStores[key]!;
  }

  @override
  Future<List<CountryEntity>?> getCountries(bool fromLocal) async {
    if (fromLocal) {
      final items = ContentStore.getLocalContentList(ContentType.roadMap);
      final countries = _getCountryListFromGemItemList(items);
      return countries;
    } else {
      final resultCompleter = Completer<List<CountryEntity>?>();

      ContentStore.asyncGetStoreContentList(ContentType.roadMap, (err, items, isCached) async {
        if (err != GemError.success || items == null) {
          resultCompleter.complete(null);
          return;
        }

        final countries = _getCountryListFromGemItemList(items);

        resultCompleter.complete(countries);
      });
      return resultCompleter.future;
    }
  }

  List<CountryEntity> _getCountryListFromGemItemList(List<ContentStoreItem> itemList) {
    List<CountryEntity> result = [];
    final Set<String> uniqueIsoCodes = {};

    for (final item in itemList) {
      final isoCode = item.countryCodes[0];
      if (uniqueIsoCodes.contains(isoCode)) continue;

      uniqueIsoCodes.add(isoCode);
      final gemLmk = GuidedAddressSearchService.getCountryLevelItem(isoCode);
      if (gemLmk == null) return [];

      CountryEntity country = CountryEntityImpl(isoCode: isoCode, name: gemLmk.name);
      result.add(country);
    }

    return result;
  }

  @override
  Future<Uint8List?> getCountryImage(String code) async {
    final rawImage = _imageCache.getCountryImage(code);
    return rawImage;
  }

  @override
  void initMapUpdateModule() {
    SdkSettings.setAllowConnection(
      true,
      onWorldwideRoadMapSupportStatusCallback: (status) {
        print("MapUpdate: onWorldwideRoadMapSupportStatus $status");
        if (status != Status.upToDate) {
          _setMapsStatus(DMapsUpdateStatus.oldData);
          _shouldAutoUpdateIfNoLocalMaps().then((shouldAutoUpdate) {
            print("MapUpdate: trigger autoupdate: $shouldAutoUpdate");
            if (shouldAutoUpdate) update();
          });
        } else {
          _setMapsStatus(DMapsUpdateStatus.upToDate);
        }

        _setModuleStatus(DMapsUpdateModuleStatus.idle);
      },
    );

    final code = ContentStore.checkForUpdate(ContentType.roadMap);
    print("MapUpdate: checkForUpdate resolved with code $code");
  }

  @override
  void cancelUpdate() {
    if (_contentUpdater == null) return;
    if (!_contentUpdater!.isStarted) return;

    _contentUpdater!.cancel();
    _setMapsStatus(DMapsUpdateStatus.oldData);
    _setModuleStatus(DMapsUpdateModuleStatus.idle);
    _setUpdateProgress(null);

    refreshCreatedRoadMapContentStores();
  }

  @override
  void update() {
    if (updateStatus != DMapsUpdateStatus.oldData) return;
    if (![DMapsUpdateModuleStatus.idle, DMapsUpdateModuleStatus.updateFailed].contains(moduleStatus)) return;

    _setModuleStatus(DMapsUpdateModuleStatus.updating);
    _contentUpdater = ContentStore.createContentUpdater(ContentType.roadMap).first;

    final statusId = _contentUpdater!.update(true, onStatusUpdated: (status) {
      print("MapUpdate: onNotifyStatusChanged with code $status");
      if (status == ContentUpdaterStatus.fullyReady || status == ContentUpdaterStatus.partiallyReady) {
        _setUpdateProgress(null);
        final code = _contentUpdater!.apply();
        print("MapUpdate: apply resolved with code $code");
        if (code == GemError.success) {
          _setModuleStatus(DMapsUpdateModuleStatus.updated);
          _setMapsStatus(DMapsUpdateStatus.upToDate);
          _setUpdateProgress(null);
        } else {
          _setModuleStatus(DMapsUpdateModuleStatus.updateFailed);
        }

        refreshCreatedRoadMapContentStores();
      }

      if (status == ContentUpdaterStatus.error) {
        _setUpdateProgress(null);
        _setModuleStatus(DMapsUpdateModuleStatus.updateFailed);
        refreshCreatedRoadMapContentStores();
      }

      if (status == ContentUpdaterStatus.waitConnection || status == ContentUpdaterStatus.waitWIFIConnection) {
        _setModuleStatus(DMapsUpdateModuleStatus.waitingConnection);
      }
    }, onProgressUpdated: (progress) {
      print("MapUpdate: progress callback with value $progress");
      _setUpdateProgress(progress);
      _setModuleStatus(DMapsUpdateModuleStatus.updating);
    });
    print("MapUpdate: update resolved with code $statusId");
    if (statusId != GemError.success) {
      _setModuleStatus(DMapsUpdateModuleStatus.updateFailed);
    }
  }

  void refreshCreatedRoadMapContentStores() {
    _contentStores.forEach((key, store) {
      if (key.$1 == DContentStoreItemType.roadMap) {
        store.refresh();
      }
    });
  }

  @override
  late final Stream<ContentStoreUpdateEvent> updateEventStream = updateController.stream.asBroadcastStream();
  final StreamController<ContentStoreUpdateEvent> updateController = StreamController<ContentStoreUpdateEvent>();

  @override
  DMapsUpdateStatus updateStatus = DMapsUpdateStatus.upToDate;

  @override
  String getUpdateMapVersion() {
    final latestVersion = MapDetails.latestOnlineMapVersion;
    return "${latestVersion.major}.${latestVersion.minor}";
  }

  void _setUpdateProgress(int? value) {
    updateProgress = value;
    updateController.add(CSUProgressChangedEvent(progressValue: updateProgress));
  }

  void _setModuleStatus(DMapsUpdateModuleStatus status) {
    moduleStatus = status;
    updateController.add(CSUModuleStatusChangedEvent(status: moduleStatus));
  }

  void _setMapsStatus(DMapsUpdateStatus status) {
    updateStatus = status;
    updateController.add(CSUStatusChangedEvent(status: updateStatus));
  }

  @override
  int? updateProgress;

  @override
  DMapsUpdateModuleStatus moduleStatus = DMapsUpdateModuleStatus.awaitingServerResponse;

  @override
  String getCurrentMapVersion() {
    final currentVersion = MapDetails.mapVersion;
    return "${currentVersion.major}.${currentVersion.minor}";
  }
}
