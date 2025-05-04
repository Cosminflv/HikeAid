import 'package:data/models/content_store_item_entity_impl.dart';
import 'package:data/models/task_progress_listener_impl.dart';
import 'package:data/utils/extensions.dart';
import 'package:data/utils/one_to_many_stream.dart';
import 'package:domain/entities/content_store_entity.dart';
import 'package:domain/entities/content_store_item_entity.dart';
import 'package:domain/repositories/task_progress_listener.dart';
import 'package:gem_kit/content_store.dart';
import 'package:gem_kit/core.dart';
import 'package:gem_kit/map.dart';

import 'dart:async';

class ContentStoreEntityImpl implements ContentStoreEntity {
  final DContentStoreItemType contentStoreItemType;
  final bool isLocal;
  final DStyleColorTheme colorTheme;

  List<ContentStoreItemEntityImpl> _items = [];
  DContentStoreItemsStatus _status = DContentStoreItemsStatus.initial;

  final _streamController = StreamController<ContentStoreItemEvent>();
  late final _oneToManyStream = OneToManyStream<ContentStoreItemEvent>(_streamController.stream);
  @override
  Stream<ContentStoreItemEvent> get eventStream => _oneToManyStream.createNewStream();

  ContentStoreEntityImpl({
    required this.contentStoreItemType,
    required this.isLocal,
    required this.colorTheme,
    GemMapController? mapController,
  }) {
    if (contentStoreItemType != DContentStoreItemType.mapStyleHighRes &&
        contentStoreItemType != DContentStoreItemType.mapStyleLowRes &&
        colorTheme != DStyleColorTheme.none) {
      throw Exception(
          "ContentStoreEntityImplementation of type $contentStoreItemType can't have colorTheme $colorTheme");
    }

    eventStream.listen((event) {
      if (event is CSIRefreshedListEvent) _notifyListenersStatusChanged();
    });
  }

  @override
  DContentStoreItemsStatus get status => _status;

  @override
  List<ContentStoreItemEntity> get items => _items;

  @override
  int get usedStorage {
    return _items.where((item) => item.isCompleted).fold(0, (total, item) => total + item.totalSize);
  }

  @override
  int get selectedIndex {
    if (_items.isEmpty) {
      return -1;
    }

    switch (contentStoreItemType) {
      case DContentStoreItemType.mapStyleHighRes:
      case DContentStoreItemType.mapStyleLowRes:
        return -1;
      case DContentStoreItemType.humanVoice:
        //final path = SdkSettings.getVoiceByPath();
        //return _items.indexWhere(((element) => element.fileName == path));
        return -1;
      default:
        return -1;
    }
  }

  @override
  void apply(newIndex) {
    final item = _items[newIndex];
    final oldIndex = selectedIndex;

    if (!item.isCompleted) return;

    switch (item.type) {
      case DContentStoreItemType.mapStyleHighRes:
        return;
      case DContentStoreItemType.mapStyleLowRes:
        return;
      case DContentStoreItemType.humanVoice:
        return;
      default:
    }

    _streamController.add(CSIAppliedItemChangedEvent(newItemIndex: newIndex, oldItemIndex: oldIndex));
  }

  @override
  void download(int index) async {
    final item = _items[index];
    if (item.isCompleted || item.isDownloadingOrWaiting) return;

    await _items[index].download(
      (err) {
        _streamController.add(CSIItemDownloadFinishedEvent(index: index));
      },
      onProgressCallback: (progress) {
        _streamController.add(CSIItemEvent(index: index));
        if (progress == 100) _streamController.add(CSIItemDownloadFinishedEvent(index: index));
      },
    );

    _streamController.add(CSIItemEvent(index: index));
  }

  @override
  void pauseDownload(int index) {
    final item = items[index];
    if (!item.isDownloadingOrWaiting) return;

    _items[index].pauseDownload();

    _streamController.add(CSIItemEvent(index: index));
  }

  @override
  void refresh() {
    print("---Refresh content store");

    if (isLocal) {
      _refreshItemsLocal();
      _streamController.add(CSIRefreshedListEvent());
    } else {
      if (status == DContentStoreItemsStatus.loaded) {
        _streamController.add(CSIRefreshedListEvent());
        return;
      }
      _refreshItemsOnline(() {
        _streamController.add(CSIRefreshedListEvent());
      });
    }
  }

  @override
  bool delete(int index) {
    if (index == selectedIndex) return false;
    final isDeleted = _items[index].delete();
    if (isDeleted) {
      refresh();
    }
    return isDeleted;
  }

  Future<TaskProgressListener2> _refreshItemsOnline(Function() onComplete) async {
    _status = DContentStoreItemsStatus.loading;

    final contentType = contentStoreItemType.toGemContentType();
    var progress = TaskProgressListenerImpl2();

    progress.ref = ContentStore.asyncGetStoreContentList(contentType, (err, items, isCached) async {
      if (err != GemError.success || items == null) {
        _items = [];
        _status = DContentStoreItemsStatus.failed;
        onComplete();
        return;
      }

      List<ContentStoreItemEntityImpl> result = [];
      for (final item in items) {
        // final name = item.getName();
        // if (contentType == EContentType.CT_ViewStyleHighRes || contentType == EContentType.CT_ViewStyleLowRes) {
        //   if (!name.contains('Cycle')) continue;
        // }

        final contentStoreItemEntity = ContentStoreItemEntityImpl(ref: item);
        if (contentStoreItemEntity.colorTheme != colorTheme) continue;
        result.add(contentStoreItemEntity);
      }

      _items = result;
      _status = DContentStoreItemsStatus.loaded;
      onComplete();
    });

    return progress;
  }

  void _refreshItemsLocal() {
    final contentType = contentStoreItemType.toGemContentType();
    final items = ContentStore.getLocalContentList(contentType);

    List<ContentStoreItemEntityImpl> result = [];
    for (final item in items) {
      // final name = item.getName();

      if (!item.isCompleted) continue;

      // if (contentType == EContentType.CT_ViewStyleHighRes || contentType == EContentType.CT_ViewStyleLowRes) {
      //   if (!name.contains('Cycle')) continue;
      // }

      final contentStoreItemEntity = ContentStoreItemEntityImpl(ref: item);
      if (contentStoreItemEntity.colorTheme != colorTheme) continue;
      result.add(contentStoreItemEntity);
    }

    _items = result;
    _status = DContentStoreItemsStatus.loaded;
  }

  @override
  void applyById(int id) {
    if (_items.isEmpty) throw "Store of type $contentStoreItemType doesn't have any items loaded";

    int index = -1;
    if (id == 0) {
      index = _getDefaultStyleIndex();
      if (index == -1) index = 0; // Apply the first style from the list if no default style is found
    } else {
      index = _items.indexWhere((element) => element.id == id);
      if (index == -1) index = _getDefaultStyleIndex();
      if (index == -1) index = 0; // Apply the first style from the list if no default style is found
    }

    apply(index);
  }

  int _getDefaultStyleIndex() {
    if (contentStoreItemType != DContentStoreItemType.mapStyleHighRes) {
      throw "Store of type $contentStoreItemType doesn't support operation _getDefaultStyle";
    }

    const defaultIdDay = 8589937785;
    const defaultIdNight = 8589937786;

    if (colorTheme == DStyleColorTheme.day) {
      return _items.indexWhere((element) => element.id == defaultIdDay);
    } else {
      return _items.indexWhere((element) => element.id == defaultIdNight);
    }
  }

  @override
  ContentStoreItemEntity? getItemWithId(int id) {
    try {
      return _items.firstWhere((element) => element.id == id);
    } catch (e) {
      return null;
    }
  }

  List<_OnLoadedListener> _onLoadedListeners = [];

  @override
  void onLoaded({
    required void Function() onLoad,
    void Function()? onFail,
    bool persistAfterFail = false,
  }) {
    final listener = _OnLoadedListener(
      onLoad: onLoad,
      onFail: onFail,
      persistAfterFail: persistAfterFail,
    );
    if (status == DContentStoreItemsStatus.loaded) {
      listener.onLoad();
      return;
    }

    if (status == DContentStoreItemsStatus.failed) {
      listener.onFail?.call();
      if (!persistAfterFail) return;
    }

    _onLoadedListeners.add(_OnLoadedListener(
      onLoad: onLoad,
      onFail: onFail,
      persistAfterFail: persistAfterFail,
    ));
  }

  void _notifyListenersStatusChanged() {
    List<_OnLoadedListener> remainingListeners = [];

    for (final listener in _onLoadedListeners) {
      if (status == DContentStoreItemsStatus.loaded) {
        listener.onLoad();
        continue;
      }
      if (status == DContentStoreItemsStatus.failed) {
        listener.onFail?.call();
        if (listener.persistAfterFail) {
          remainingListeners.add(listener);
        }
      }
    }

    _onLoadedListeners = remainingListeners;
  }
}

class _OnLoadedListener {
  void Function() onLoad;
  void Function()? onFail;
  bool persistAfterFail;

  _OnLoadedListener({
    required this.onLoad,
    this.onFail,
    required this.persistAfterFail,
  });
}
