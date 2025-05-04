import 'package:domain/entities/connectivity_status.dart';
import 'package:domain/entities/content_store_item_entity.dart';
import 'package:domain/use_cases/content_store_use_case.dart';

abstract class ContentStoreEvent {}

class ItemTapEvent extends ContentStoreEvent {
  int index;

  ItemTapEvent({required this.index});
}

class UpdateContentStoreSourceEvent extends ContentStoreEvent {
  DContentStoreItemType type;
  ContentStoreSource source;

  UpdateContentStoreSourceEvent({
    required this.type,
    required this.source,
  });
}

class DeleteItemEvent extends ContentStoreEvent {
  int index;
  ContentStoreSource source;

  DeleteItemEvent({required this.index, required this.source});
}

class RefreshItemsListEvent extends ContentStoreEvent {
  RefreshItemsListEvent();
}

class UpdateFilterTextEvent extends ContentStoreEvent {
  final String query;

  UpdateFilterTextEvent({required this.query});
}

class UpdateStatusesEvent extends ContentStoreEvent {}

class UpdateProgressChangedEvent extends ContentStoreEvent {}

class StartUpdateEvent extends ContentStoreEvent {}

class CancelUpdateEvent extends ContentStoreEvent {}

class ConnectivityUpdateEvent extends ContentStoreEvent {
  final DConnectivityStatus status;
  ConnectivityUpdateEvent({required this.status});
}

class MapUpdatedCardDismissedEvent extends ContentStoreEvent {}
