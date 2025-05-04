enum DContentStoreItemType { roadMap, mapStyleHighRes, mapStyleLowRes, humanVoice, computerVoice, carModel, unknown }

enum DContentStoreItemStatus {
  unavailable,
  completed,
  paused,
  downloadQueued,
  downloadWaitingNetwork,
  downloadWaiting,
  downloadWaitingFreeNetwork,
  downloadRunning,
  updateWaiting
}

enum DScriptVariant { native, transcription, transliteration }

enum DStyleColorTheme { none, night, day }

class DefaultMapStyleIds {
  static int get day => 8589937785;
  static int get night => 8589937786;
}

abstract class ContentStoreItemEntity {
  int get id;
  DContentStoreItemType get type;
  String get name;
  int get totalSize;
  String get fileName;
  List<String> get countryCodes;
  DContentStoreItemStatus get status;
  int get downloadProgress;

  bool get isCompleted;
  bool get isDownloadingOrWaiting;
  DStyleColorTheme get colorTheme;
}
