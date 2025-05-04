import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:domain/entities/content_store_entity.dart';
import 'package:domain/entities/content_store_item_entity.dart';
import 'package:domain/entities/country_entity.dart';
import 'package:domain/entities/local_map_style_entity.dart';

abstract class ContentStoreRepository {
  Future<List<LocalMapStyleEntity>> getAvailableLocalStyles();

  ContentStoreEntity getContentStore({
    required DContentStoreItemType type,
    required bool isLocal,
    required DStyleColorTheme colorTheme,
  });
  Future<List<CountryEntity>?> getCountries(bool fromLocal);

  Uint8List? getItemPreview(ContentStoreItemEntity item);
  Future<Uint8List?> getCountryImage(String code);

  //Update
  void initMapUpdateModule();
  void update();
  void cancelUpdate();
  Stream<ContentStoreUpdateEvent> get updateEventStream;
  DMapsUpdateStatus get updateStatus;
  DMapsUpdateModuleStatus get moduleStatus;
  int? get updateProgress;

  String getCurrentMapVersion();
  String getUpdateMapVersion();
}

typedef ContentStoreResult = Either<int, List<ContentStoreItemEntity>>;

enum DMapsUpdateStatus {
  oldData,
  upToDate,
}

enum DMapsUpdateModuleStatus {
  awaitingServerResponse,
  idle,
  updating,
  updated,
  updateFailed,
  waitingConnection,
}

abstract class ContentStoreUpdateEvent {}

class CSUStatusChangedEvent extends ContentStoreUpdateEvent {
  DMapsUpdateStatus status;
  CSUStatusChangedEvent({required this.status});
}

class CSUModuleStatusChangedEvent extends ContentStoreUpdateEvent {
  DMapsUpdateModuleStatus status;
  CSUModuleStatusChangedEvent({required this.status});
}

class CSUProgressChangedEvent extends ContentStoreUpdateEvent {
  int? progressValue;
  CSUProgressChangedEvent({required this.progressValue});
}
