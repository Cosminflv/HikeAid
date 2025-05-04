import 'package:data/models/task_progress_listener_impl.dart';
import 'package:data/utils/extensions.dart';
import 'package:domain/entities/content_store_item_entity.dart';
import 'package:domain/repositories/task_progress_listener.dart';
import 'package:gem_kit/content_store.dart';
import 'package:gem_kit/core.dart';

class ContentStoreItemEntityImpl extends ContentStoreItemEntity {
  final ContentStoreItem ref;

  ContentStoreItemEntityImpl({required this.ref});

  Future<TaskProgressListener2> download(void Function(int) onCompleteCallback,
      {void Function(int)? onProgressCallback}) async {
    final progressListener = ref.asyncDownload((err) {
      onCompleteCallback(err.code);
    }, onProgressCallback: (v) {
      if (onProgressCallback != null) onProgressCallback(v);
    }, allowChargedNetworks: true);

    return TaskProgressListenerImpl2(ref: progressListener);
  }

  @override
  int get id => ref.id;

  bool delete() {
    //Should not allow deleting default styles
    if (id == DefaultMapStyleIds.day || id == DefaultMapStyleIds.night) return false;

    return ref.deleteContent() == GemError.success;
  }

  @override
  List<String> get countryCodes => ref.countryCodes;

  @override
  int get downloadProgress => ref.downloadProgress;

  @override
  String get fileName => ref.fileName;

  @override
  bool get isCompleted => ref.isCompleted;

  @override
  String get name => ref.name;

  @override
  DContentStoreItemStatus get status => ref.status.toEntityImpl();

  @override
  int get totalSize => ref.totalSize;

  @override
  DContentStoreItemType get type => ref.type.toEntityImpl();

  @override
  bool get isDownloadingOrWaiting {
    switch (status) {
      case DContentStoreItemStatus.downloadQueued:
      case DContentStoreItemStatus.downloadRunning:
      case DContentStoreItemStatus.downloadWaiting:
      case DContentStoreItemStatus.downloadWaitingFreeNetwork:
      case DContentStoreItemStatus.downloadWaitingNetwork:
        return true;
      default:
    }

    return false;
  }

  GemError pauseDownload() {
    return ref.pauseDownload();
  }

  @override
  DStyleColorTheme get colorTheme {
    if (type != DContentStoreItemType.mapStyleHighRes && type != DContentStoreItemType.mapStyleLowRes) {
      return DStyleColorTheme.none;
    }

    //TODO replace hardcoded values when SDK feature available
    const nightStyleIds = [
      8589936549,
      8589936550,
      8589935705,
      8589935246,
      8589935278,
      8589935280,
      8589937786,
    ];

    if (nightStyleIds.contains(id)) {
      return DStyleColorTheme.night;
    }

    return DStyleColorTheme.day;
  }
}
