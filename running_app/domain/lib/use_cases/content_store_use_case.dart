import 'dart:async';
import 'dart:typed_data';

import 'package:domain/entities/content_store_entity.dart';
import 'package:domain/entities/content_store_item_entity.dart';
import 'package:domain/entities/local_map_style_entity.dart';
import 'package:domain/repositories/content_store_repository.dart';

enum ContentStoreSource { local, remote }

typedef ContentStoreKey = (DContentStoreItemType, ContentStoreSource, DStyleColorTheme);

class ContentStoreUseCase {
  final ContentStoreRepository _repository;

  ContentStoreUseCase(this._repository);

  Future<List<LocalMapStyleEntity>> getAvailableLocalStyles() async => await _repository.getAvailableLocalStyles();

  ContentStoreEntity _getStore(ContentStoreKey key) {
    final store =
        _repository.getContentStore(type: key.$1, isLocal: key.$2 == ContentStoreSource.local, colorTheme: key.$3);
    return store;
  }

  List<ContentStoreItemEntity> getItems(ContentStoreKey key) {
    return _getStore(key).items;
  }

  DContentStoreItemsStatus getStatus(ContentStoreKey key) {
    return _getStore(key).status;
  }

  int getSelectedIndex(ContentStoreKey key) {
    return _getStore(key).selectedIndex;
  }

  void refresh(ContentStoreKey key) {
    _getStore(key).refresh();
  }

  void applyById(ContentStoreKey key, int id, bool withDelay) {
    final store = _getStore(key);

    if (key.$1 == DContentStoreItemType.mapStyleHighRes ||
        key.$1 == DContentStoreItemType.mapStyleLowRes ||
        key.$1 == DContentStoreItemType.roadMap) {
      return;
    }

    store.applyById(id);

    if (store.status != DContentStoreItemsStatus.loaded && store.status != DContentStoreItemsStatus.loading) {
      store.refresh();
    }
  }

  bool delete(ContentStoreKey key, int index) {
    return _getStore(key).delete(index);
  }

  void download(ContentStoreKey key, int index) {
    final store = _getStore(key);
    final localStore = _getStore((key.$1, ContentStoreSource.local, key.$3));

    //Trigger local content store refresh shortly after an item fisishes download
    StreamSubscription? streamSubscription;
    streamSubscription = store.eventStream.listen((event) {
      if (streamSubscription == null) return;
      if (event is CSIItemDownloadFinishedEvent && event.index == index) {
        Future.delayed(Duration(milliseconds: 300), () => localStore.refresh());
        streamSubscription!.cancel();
        streamSubscription = null;
      }
    });

    store.download(index);
  }

  void pause(ContentStoreKey key, int index) {
    return _getStore(key).pauseDownload(index);
  }

  Stream<ContentStoreItemEvent> getStream(ContentStoreKey key) {
    return _getStore(key).eventStream;
  }

  Uint8List? getItemPreview(ContentStoreKey key, int index) {
    final item = _getStore(key).items[index];

    return _repository.getItemPreview(item);
  }

  String? getStyleNameById(int id) {
    final dayStyles = _repository.getContentStore(
      type: DContentStoreItemType.mapStyleHighRes,
      isLocal: true,
      colorTheme: DStyleColorTheme.day,
    );

    final nightStyles = _repository.getContentStore(
      type: DContentStoreItemType.mapStyleHighRes,
      isLocal: true,
      colorTheme: DStyleColorTheme.night,
    );

    final dayItem = dayStyles.getItemWithId(id);
    if (dayItem != null) {
      return dayItem.name;
    }

    final nightItem = nightStyles.getItemWithId(id);
    if (nightItem != null) {
      return nightItem.name;
    }

    return null;
  }

  // Update module
  void initMapUpdateModule() {
    _repository.initMapUpdateModule();
  }

  void update() {
    _repository.update();
  }

  void cancelUpdate() {
    _repository.cancelUpdate();
  }

  Stream<ContentStoreUpdateEvent> get updateEventStream => _repository.updateEventStream;

  DMapsUpdateStatus get updateStatus => _repository.updateStatus;

  DMapsUpdateModuleStatus get moduleStatus => _repository.moduleStatus;

  int? get updateProgress => _repository.updateProgress;

  String getUpdateMapsVersion() {
    return _repository.getUpdateMapVersion();
  }

  String getCurrentMapVersion() {
    return _repository.getCurrentMapVersion();
  }
}
