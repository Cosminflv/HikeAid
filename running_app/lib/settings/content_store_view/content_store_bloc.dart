import 'dart:typed_data';

import 'package:core/di/injection_container.dart';
import 'package:domain/entities/content_store_entity.dart';
import 'package:domain/entities/content_store_item_entity.dart';
import 'package:domain/repositories/content_store_repository.dart';
import 'package:domain/use_cases/content_store_use_case.dart';

import 'content_store_events.dart';
import 'content_store_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import 'content_store_view_item.dart';

class ContentStoreBloc extends Bloc<ContentStoreEvent, ContentStoreState> {
  final ContentStoreUseCase _contentStoreUsecase = sl.get<ContentStoreUseCase>();

  StreamSubscription? _contentStoreStreamSubscription;
  StreamSubscription? _contentStoreUpdateStreamSubscription;

  ContentStoreBloc() : super(ContentStoreState()) {
    on<ItemTapEvent>(_itemTapEventHandler);
    on<DeleteItemEvent>(_deleteItemEventHandler);

    on<UpdateContentStoreSourceEvent>(_updateContentStoreSourceEventHandler);
    on<RefreshItemsListEvent>(_refreshItemsListEventHandler);

    on<UpdateFilterTextEvent>(_updateFilterTextEventHandler);

    on<UpdateStatusesEvent>(_updateStatusesEventHandler);
    on<UpdateProgressChangedEvent>(_updateProgressChangedEventHandler);
    on<StartUpdateEvent>(_startUpdateEventHandler);
    on<CancelUpdateEvent>(_cancelUpdateEvent);

    on<ConnectivityUpdateEvent>(_connectivityUpdateEventHandler);
    on<MapUpdatedCardDismissedEvent>(_mapUpdatedCardDismissedEventHandler);

    _contentStoreUpdateStreamSubscription = _contentStoreUsecase.updateEventStream.listen((event) {
      if (isClosed) return;
      if (event is CSUStatusChangedEvent || event is CSUModuleStatusChangedEvent) {
        add(UpdateStatusesEvent());
        return;
      }
      if (event is CSUProgressChangedEvent) {
        add(UpdateProgressChangedEvent());
      }
    });

    add(UpdateStatusesEvent());
    add(UpdateProgressChangedEvent());
  }

  Uint8List? getItemPreview(int index) => _contentStoreUsecase.getItemPreview(state.key, index);

  _itemTapEventHandler(ItemTapEvent event, Emitter<ContentStoreState> emit) async {
    final index = event.index;
    final itemByIndex = _contentStoreUsecase.getItems(state.key)[index];
    final source = state.contentStoreSource;

    // Resume paused download content
    if (itemByIndex.status == DContentStoreItemStatus.paused) {
      _contentStoreUsecase.download(state.key, event.index);
      return;
    }

    // Pause downloading content
    if (itemByIndex.isDownloadingOrWaiting) {
      _contentStoreUsecase.pause(state.key, index);
      return;
    }

    // // Apply not selected downloaded content
    // if (itemByIndex.isCompleted && state.selectedItemIndex != index) {
    //   _contentStoreUsecase.apply(state.key, index);
    //   return;
    // }

    // Download remote not downloading content
    if (source == ContentStoreSource.remote && itemByIndex.isDownloadingOrWaiting == false) {
      _contentStoreUsecase.download(state.key, event.index);
      return;
    }
  }

  _updateContentStoreSourceEventHandler(UpdateContentStoreSourceEvent event, Emitter<ContentStoreState> emit) {
    emit(state.copyWith(
      contentStoreSource: event.source,
      contentStoreType: event.type,
      status: DContentStoreItemsStatus.loading,
      items: [],
    ));

    if (_contentStoreStreamSubscription != null) {
      _contentStoreStreamSubscription!.cancel();
      _contentStoreStreamSubscription = null;
    }

    _contentStoreStreamSubscription = _contentStoreUsecase.getStream(state.key).listen((event) {
      if (isClosed) {
        _contentStoreStreamSubscription!.cancel();
        _contentStoreStreamSubscription = null;
        return;
      }

      if (event is CSIItemEvent) {
        final filteredPos = indexToFilteredListPosition(event.index);
        if (filteredPos == -1) return;
        final tuple = state.items[filteredPos];
        final item = tuple.$1;
        final controller = tuple.$3;

        controller.setStatus(item.status);
        controller.setProgress(item.downloadProgress);
        controller.setSelected(_contentStoreUsecase.getSelectedIndex(state.key) == event.index);
        return;
      }

      add(RefreshItemsListEvent());
    });

    _contentStoreUsecase.refresh(state.key);
  }

  _deleteItemEventHandler(DeleteItemEvent event, Emitter<ContentStoreState> emit) {
    _contentStoreUsecase.delete(state.key, event.index);
  }

  _refreshItemsListEventHandler(RefreshItemsListEvent event, Emitter<ContentStoreState> emit) {
    emit(state.copyWith(
      selectedItemIndex: _contentStoreUsecase.getSelectedIndex(state.key),
      items: filterItems(_contentStoreUsecase.getItems(state.key), query: state.query),
      status: _contentStoreUsecase.getStatus(state.key),
      usedStorage: 0,
    ));
  }

  _updateFilterTextEventHandler(UpdateFilterTextEvent event, Emitter<ContentStoreState> emit) {
    emit(state.copyWith(
      query: event.query,
      items: filterItems(_contentStoreUsecase.getItems(state.key), query: event.query),
    ));
  }

  List<(ContentStoreItemEntity, int, ContentStoreViewItemController)> filterItems(List<ContentStoreItemEntity> items,
      {String query = ""}) {
    query = query.toLowerCase();
    final size = items.length;

    List<(ContentStoreItemEntity, int, ContentStoreViewItemController)> result = [];
    for (int i = 0; i < size; i++) {
      final item = items[i];
      if (!item.name.toLowerCase().contains(query)) continue;
      result.add((item, i, ContentStoreViewItemController()));
    }

    return result;
  }

  int indexToFilteredListPosition(int index) {
    return state.items.indexWhere((element) => element.$2 == index);
  }

  _startUpdateEventHandler(StartUpdateEvent event, Emitter<ContentStoreState> emit) {
    _contentStoreUsecase.update();
  }

  _cancelUpdateEvent(CancelUpdateEvent event, Emitter<ContentStoreState> emit) {
    _contentStoreUsecase.cancelUpdate();
  }

  _updateProgressChangedEventHandler(UpdateProgressChangedEvent event, Emitter<ContentStoreState> emit) {
    final updateProgress = _contentStoreUsecase.updateProgress;
    if (updateProgress == null) {
      emit(state.copyWithNullUpdateProgress());
    } else {
      emit(state.copyWith(updateProgress: updateProgress));
    }
  }

  _updateStatusesEventHandler(UpdateStatusesEvent event, Emitter<ContentStoreState> emit) async {
    final mapsUpdateStatus = _contentStoreUsecase.updateStatus;
    final updateModuleStatus = _contentStoreUsecase.moduleStatus;
    final currentMapVersion = _contentStoreUsecase.getCurrentMapVersion();
    final newMapVersion = _contentStoreUsecase.getUpdateMapsVersion();

    emit(state.copyWith(
      mapsUpdateStatus: mapsUpdateStatus,
      updateModuleStatus: updateModuleStatus,
      currentMapsVersion: currentMapVersion,
      availableMapsVersion: newMapVersion,
    ));
  }

  _connectivityUpdateEventHandler(ConnectivityUpdateEvent event, Emitter<ContentStoreState> emit) async {
    final connectionStatus = event.status;
    emit(state.copyWith(isConnected: connectionStatus.isConnected()));
  }

  _mapUpdatedCardDismissedEventHandler(MapUpdatedCardDismissedEvent event, Emitter<ContentStoreState> emit) async {
    emit(state.copyWith(updateModuleStatus: DMapsUpdateModuleStatus.idle));
  }

  String? getStyleNameById(int id) => _contentStoreUsecase.getStyleNameById(id);

  @override
  Future<void> close() async {
    super.close();
    if (_contentStoreStreamSubscription != null) {
      _contentStoreStreamSubscription!.cancel();
      _contentStoreStreamSubscription = null;
    }

    if (_contentStoreUpdateStreamSubscription != null) {
      _contentStoreUpdateStreamSubscription!.cancel();
      _contentStoreUpdateStreamSubscription = null;
    }
  }
}
