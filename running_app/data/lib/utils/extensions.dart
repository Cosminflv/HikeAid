import 'package:domain/entities/content_store_item_entity.dart';
import 'package:gem_kit/content_store.dart';

extension GemContentStoreItemStatusExtension on ContentStoreItemStatus {
  DContentStoreItemStatus toEntityImpl() {
    switch (this) {
      case ContentStoreItemStatus.unavailable:
        return DContentStoreItemStatus.unavailable;

      case ContentStoreItemStatus.completed:
        return DContentStoreItemStatus.completed;

      case ContentStoreItemStatus.paused:
        return DContentStoreItemStatus.paused;

      case ContentStoreItemStatus.downloadQueued:
        return DContentStoreItemStatus.downloadQueued;

      case ContentStoreItemStatus.downloadWaitingNetwork:
        return DContentStoreItemStatus.downloadWaitingNetwork;

      case ContentStoreItemStatus.downloadWaiting:
        return DContentStoreItemStatus.downloadWaiting;

      case ContentStoreItemStatus.downloadWaitingFreeNetwork:
        return DContentStoreItemStatus.downloadWaitingFreeNetwork;

      case ContentStoreItemStatus.downloadRunning:
        return DContentStoreItemStatus.downloadRunning;

      case ContentStoreItemStatus.updateWaiting:
        return DContentStoreItemStatus.updateWaiting;
    }
  }
}

extension GetContentTypeExtension on ContentType {
  DContentStoreItemType toEntityImpl() {
    switch (this) {
      case ContentType.viewStyleHighRes:
        return DContentStoreItemType.mapStyleHighRes;
      case ContentType.viewStyleLowRes:
        return DContentStoreItemType.mapStyleLowRes;
      case ContentType.roadMap:
        return DContentStoreItemType.roadMap;
      case ContentType.humanVoice:
        return DContentStoreItemType.humanVoice;
      case ContentType.computerVoice:
        return DContentStoreItemType.computerVoice;
      case ContentType.carModel:
        return DContentStoreItemType.carModel;
      case ContentType.unknown:
        return DContentStoreItemType.unknown;
    }
  }
}

extension ContentStoreItemTypeExtension on DContentStoreItemType {
  ContentType toGemContentType() {
    switch (this) {
      case DContentStoreItemType.roadMap:
        return ContentType.roadMap;
      case DContentStoreItemType.mapStyleHighRes:
        return ContentType.viewStyleHighRes;
      case DContentStoreItemType.mapStyleLowRes:
        return ContentType.viewStyleLowRes;
      case DContentStoreItemType.humanVoice:
        return ContentType.humanVoice;
      case DContentStoreItemType.computerVoice:
        return ContentType.computerVoice;
      case DContentStoreItemType.carModel:
        return ContentType.carModel;
      case DContentStoreItemType.unknown:
        return ContentType.unknown;
    }
  }
}
