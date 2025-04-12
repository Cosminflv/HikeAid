import 'dart:convert';
import 'dart:typed_data';

import 'package:data/models/recorder_entity_impl.dart';

import 'package:domain/repositories/recorder_repository.dart';

import 'package:gem_kit/sense.dart';

import 'package:path_provider/path_provider.dart';

import 'dart:io' as io;

class RecorderRepositoryImpl extends RecorderRepository {
  RecorderEntityImpl? _recorder;
  RecorderConfiguration? _recorderConfiguration;
  DateTime? startRecordingTimestamp;
  io.Directory? _documentsDirectory;

  RecorderRepositoryImpl() {
    if (io.Platform.isAndroid) {
      getExternalStorageDirectory().then((dir) => _documentsDirectory = dir);
    } else if (io.Platform.isIOS) {
      getApplicationDocumentsDirectory().then((dir) => _documentsDirectory = dir);
    }
  }

  String get _tracksDirectoryPath => "${_documentsDirectory!.path}/Data/Tracks";

  @override
  Future<void> startRecording() async {
    if (_recorder != null) {
      _recorder!.ref.stopRecording();
      _recorder!.ref.dispose();
      _recorder = null;
      _recorderConfiguration = null;
      startRecordingTimestamp = null;
    }

    if (_recorder == null && _recorderConfiguration == null) {
      await _ensureDirectoryIsCreated(_tracksDirectoryPath);
      final absPath = _tracksDirectoryPath;

      List<DataType> array = [];
      array.add(DataType.position);

      _recorderConfiguration = RecorderConfiguration(
          logsDir: absPath,
          recordedTypes: array,
          minDurationSeconds: 0,
          dataSource: DataSource.createLiveDataSource()!);

      _recorder = RecorderEntityImpl(Recorder.create(_recorderConfiguration!));
    }

    _recorder!.ref.startRecording();
    startRecordingTimestamp = DateTime.now();
  }

  @override
  Future<String> stopRecording() async {
    _recorder!.ref.stopRecording();
    await _ensureDirectoryIsCreated(_tracksDirectoryPath);

    final bookmarks = RecorderBookmarks.create(_tracksDirectoryPath);
    final logList = bookmarks!.getLogsList();

    return logList.last;
  }

  Future<void> _ensureDirectoryIsCreated(String path) async {
    if (_documentsDirectory == null) {
      if (io.Platform.isAndroid) {
        _documentsDirectory = await getExternalStorageDirectory();
      } else if (io.Platform.isIOS) {
        _documentsDirectory = await getApplicationDocumentsDirectory();
      }
    }

    final previewsDirectory = io.Directory(path);

    if (!(await previewsDirectory.exists())) {
      await previewsDirectory.create(recursive: true);
    }
  }

  // @override
  // Future<void> shareAsGPX(File gpxFile) async {
  //   final gpxXFile = XFile(gpxFile.path);
  //   await Share.shareXFiles([gpxXFile]);
  // }

  @override
  Future<String> exportGMToGPX(Uint8List binaryGM, String gmFileName) async {
    final gmFile = io.File('$_tracksDirectoryPath/$gmFileName.gm');
    await gmFile.writeAsBytes(binaryGM);

    final name = gmFile.path.split('/').last.split('.').first;

    final bookmarks = RecorderBookmarks.create(_tracksDirectoryPath);
    bookmarks!.exportLog(gmFile.path, FileType.gpx, exportedFileName: name);

    return '$_tracksDirectoryPath/$name.gpx';
  }

  // @override
  // Future<PickGPXResult?> pickGPX() async {
  //   final result = await fp.FilePicker.platform.pickFiles(
  //     type: io.Platform.isAndroid ? fp.FileType.any : fp.FileType.custom,
  //     allowedExtensions: io.Platform.isAndroid ? null : ['gpx'],
  //   );

  //   if (result == null) return null;
  //   if (result.files.isEmpty) return null;
  //   if (result.files.first.extension != 'gpx') return null;

  //   final tour = await TourBuilder.build(io.File(result.files.first.path!));
  //   if (tour == null) return null;

  //   return PickGPXResult(tour: tour, gpxPath: result.files.first.path!);
  // }

  // @override
  // void registerForIncomingGPXIntents(void Function(TourEntity tour, String gpxPath) onTourReceived) {
  //   ReceiveSharingIntent.instance.getMediaStream().listen((value) async {
  //     if (value.isEmpty) return;
  //     final importedFile = value.first;

  //     final gpxPath = importedFile.path;
  //     final tour = await TourBuilder.build(File(gpxPath));

  //     if (tour == null) return;

  //     onTourReceived(tour, gpxPath);
  //   }, onError: (err) {});

  //   ReceiveSharingIntent.instance.getInitialMedia().then((value) async {
  //     if (value.isEmpty) return;
  //     final importedFile = value.first;

  //     final tour = await TourBuilder.build(File(importedFile.path));

  //     if (tour == null) return;
  //     ReceiveSharingIntent.instance.reset();
  //   });
  // }

  @override
  Future<String> importGPXFromBinary(Uint8List binaryData) async {
    final gpxFile = io.File('$_tracksDirectoryPath/${DateTime.now().millisecondsSinceEpoch}.gpx');

    await gpxFile.create();

    String gpxString = utf8.decode(binaryData);
    Uint8List decodedGpxData = base64.decode(gpxString);

    await gpxFile.writeAsBytes(decodedGpxData);

    return importGPXFromPath(gpxFile.path);
  }

  @override
  String importGPXFromPath(String gpxPath) {
    final name = gpxPath.split('/').last.split('.').first;

    final recorder = RecorderBookmarks.create(_tracksDirectoryPath);
    final res = recorder!.importLog(gpxPath, importedFileName: name);

    return '$_tracksDirectoryPath/$name.gm';
  }

  // @override
  // Future<void> shareTourUrl(String url) => Share.share(url);
}
