import 'package:domain/entities/content_store_entity.dart';
import 'package:domain/entities/content_store_item_entity.dart';
import 'package:domain/repositories/content_store_repository.dart';
import 'package:domain/use_cases/content_store_use_case.dart';

import 'content_store_view_item.dart';

// Should not extends Equatable
class ContentStoreState {
  final ContentStoreSource contentStoreSource;
  final DContentStoreItemType contentStoreType;
  final DStyleColorTheme colorTheme;
  final int selectedItemIndex;

  final List<(ContentStoreItemEntity, int, ContentStoreViewItemController)> items;

  final DContentStoreItemsStatus status;

  final String query;

  final DMapsUpdateStatus mapsUpdateStatus;
  final DMapsUpdateModuleStatus updateModuleStatus;
  final int? updateProgress;

  final String currentMapsVersion;
  final String availableMapsVersion;

  ContentStoreState({
    this.contentStoreSource = ContentStoreSource.local,
    this.contentStoreType = DContentStoreItemType.unknown,
    this.colorTheme = DStyleColorTheme.none,
    this.selectedItemIndex = -1,
    this.items = const [],
    this.status = DContentStoreItemsStatus.initial,
    this.query = "",
    this.mapsUpdateStatus = DMapsUpdateStatus.upToDate,
    this.updateModuleStatus = DMapsUpdateModuleStatus.awaitingServerResponse,
    this.updateProgress,
    this.currentMapsVersion = "",
    this.availableMapsVersion = "",
  });

  (DContentStoreItemType, ContentStoreSource, DStyleColorTheme) get key =>
      (contentStoreType, contentStoreSource, colorTheme);

  ContentStoreState copyWithNullUpdateProgress() {
    return ContentStoreState(
      contentStoreSource: contentStoreSource,
      contentStoreType: contentStoreType,
      selectedItemIndex: selectedItemIndex,
      items: items,
      status: status,
      query: query,
      mapsUpdateStatus: mapsUpdateStatus,
      updateModuleStatus: updateModuleStatus,
      updateProgress: null,
      currentMapsVersion: currentMapsVersion,
      availableMapsVersion: availableMapsVersion,
      colorTheme: colorTheme,
    );
  }

  ContentStoreState copyWith({
    ContentStoreSource? contentStoreSource,
    DContentStoreItemType? contentStoreType,
    int? selectedItemIndex,
    List<(ContentStoreItemEntity, int, ContentStoreViewItemController)>? items,
    DContentStoreItemsStatus? status,
    int? usedStorage,
    String? query,
    DMapsUpdateStatus? mapsUpdateStatus,
    DMapsUpdateModuleStatus? updateModuleStatus,
    int? updateProgress,
    String? currentMapsVersion,
    String? availableMapsVersion,
    bool? isConnected,
    DStyleColorTheme? colorTheme,
  }) {
    return ContentStoreState(
      contentStoreSource: contentStoreSource ?? this.contentStoreSource,
      contentStoreType: contentStoreType ?? this.contentStoreType,
      selectedItemIndex: selectedItemIndex ?? this.selectedItemIndex,
      items: items ?? this.items,
      status: status ?? this.status,
      query: query ?? this.query,
      mapsUpdateStatus: mapsUpdateStatus ?? this.mapsUpdateStatus,
      updateModuleStatus: updateModuleStatus ?? this.updateModuleStatus,
      updateProgress: updateProgress ?? this.updateProgress,
      currentMapsVersion: currentMapsVersion ?? this.currentMapsVersion,
      availableMapsVersion: currentMapsVersion ?? this.availableMapsVersion,
      colorTheme: colorTheme ?? this.colorTheme,
    );
  }
}
