import 'package:domain/entities/content_store_item_entity.dart';

enum DContentStoreItemsStatus { initial, loading, loaded, failed }

abstract class ContentStoreItemEvent {}

class CSIItemEvent implements ContentStoreItemEvent {
  int index;
  CSIItemEvent({required this.index});
}

class CSIItemDownloadFinishedEvent extends CSIItemEvent {
  CSIItemDownloadFinishedEvent({required super.index});
}

class CSIAppliedItemChangedEvent implements ContentStoreItemEvent {
  int newItemIndex;
  int oldItemIndex;
  CSIAppliedItemChangedEvent({required this.newItemIndex, required this.oldItemIndex});
}

class CSIRefreshedListEvent implements ContentStoreItemEvent {}

abstract class ContentStoreEntity {
  DContentStoreItemsStatus get status;
  List<ContentStoreItemEntity> get items;
  ContentStoreItemEntity? getItemWithId(int id);
  int get usedStorage;
  int get selectedIndex;
  Stream<ContentStoreItemEvent> get eventStream;

  void apply(int index);
  void applyById(int id);
  void download(int index);
  void pauseDownload(int index);
  void refresh();
  bool delete(int index);

  /// The [onLoad] callback will be invoked immediately if the content status is already "loaded",
  /// or it will be triggered the next time the status changes to "loaded" unless listener is removed.
  ///
  /// If [persistAfterFail] is false, the listener will be removed after the first "failed" or "loaded" status.
  /// Otherwise the listener is removed only when [onLoad] is first called.
  ///
  /// If provided, the [onFail] callback will be invoked immediately if the content status is already "failed",
  /// or it will be triggered the next time the status changes to "failed" unless listener is removed.
  ///
  /// Parameters:
  ///   - onLoad: The callback function to be executed when the content is successfully loaded.
  ///   - onFail: Optional callback function to be executed if the content loading fails.
  ///   - persistAfterFail: Optional parameter to specify whether to persist the listener after a failed attempt.
  void onLoaded({
    required void Function() onLoad,
    void Function()? onFail,
    bool persistAfterFail = false,
  });
}
