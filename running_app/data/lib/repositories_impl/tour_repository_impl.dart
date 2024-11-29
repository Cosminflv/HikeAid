import 'package:data/models/recorder_entity_impl.dart';
import 'package:data/utils/tour_builder.dart';

import 'package:domain/entities/tour_entity.dart';
import 'package:domain/repositories/tour_repository.dart';
import 'package:gem_kit/sense.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'dart:io' as io;
import 'dart:io';
import 'dart:typed_data';

class TourRepositoryImpl extends TourRepository {
  RecorderEntityImpl? _recorder;
  RecorderConfiguration? _recorderConfiguration;
  DateTime? startRecordingTimestamp;
  Directory? _documentsDirectory;

  TourRepositoryImpl() {
    if (io.Platform.isAndroid) {
      getExternalStorageDirectory().then((dir) => _documentsDirectory = dir);
    } else if (io.Platform.isIOS) {
      getApplicationDocumentsDirectory().then((dir) => _documentsDirectory = dir);
    }
  }

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

      _recorderConfiguration = RecorderConfiguration(logsDir: absPath, recordedTypes: array, minDurationSeconds: 0);

      _recorder = RecorderEntityImpl(Recorder.create(_recorderConfiguration!));
    }

    _recorder!.ref.startRecording();
    startRecordingTimestamp = DateTime.now();
  }

  @override
  Future<TourEntity?> stopRecording({Uint8List? preview}) async {
    if (_recorder == null) return null;

    _recorder!.ref.stopRecording();
    await _ensureDirectoryIsCreated(_tracksDirectoryPath);

    final bookmarks = RecorderBookmarks.create(_tracksDirectoryPath);
    final logList = bookmarks.logsList;

    final startTimestamp = startRecordingTimestamp.toString();
    final gpxFileName = 'Tour_Record_$startTimestamp';

    if (logList.isEmpty) {
      return null;
    }

    bookmarks.exportLog(logList.last, FileType.gpx, exportedFileName: gpxFileName);

    if (preview != null) {
      await _ensureDirectoryIsCreated(_tracksPreviewPath);

      final fileCompletePath = join(_tracksPreviewPath, '$gpxFileName.jpg');
      File file = File(fileCompletePath);

      await file.writeAsBytes(preview);
    }

    final tours = await getRecordedTours();
    final lastRecordedTour = tours.firstWhere((tour) => tour.name == '$gpxFileName.gpx');

    return lastRecordedTour;
  }

  // @override
  // Future<void> delete(TourEntity tour) async {
  //   final file = io.File(tour.filePath);
  //   await file.delete();
  //   if (tour.type == TourTypes.planned) {
  //     await file.parent.delete();
  //   }

  //   final previewName = (tour.type == TourTypes.completed)
  //       ? '${tour.name.split('.').first}.jpg'
  //       : _getPreviewWithDate(tour.filePath).replaceAll('gpx', 'jpg');
  //   final previewFile = io.File('$_tracksPreviewPath/$previewName');

  //   if (await previewFile.exists()) {
  //     previewFile.delete();
  //   }
  // }

  @override
  Future<List<TourEntity>> getRecordedTours() async {
    await _ensureDirectoryIsCreated(_tracksDirectoryPath);

    final io.Directory directory = io.Directory(_tracksDirectoryPath);
    final List<io.FileSystemEntity> trackDirFiles = await directory.list().toList();

    final recordedTours = <TourEntity>[];

    for (final file in trackDirFiles) {
      if (file is! io.File || !file.path.toLowerCase().endsWith('.gpx')) continue;
      final preview = await _readPreviewForGPX(file.path.split('/').last);
      final tour = await TourBuilder.build(file, preview: preview);
      if (tour == null) continue;

      recordedTours.add(tour);
    }

    return recordedTours;
  }

  // @override
  // Future<void> rename({required TourEntity tour, required String newName}) async {
  //   final gpxFile = File(tour.filePath);
  //   final previewfile = File(tour.getCorrespondingPreviewPath(_tracksPreviewPath));

  //   final newGpxNameWithExtension = newName.contains('.gpx') ? newName : '$newName.gpx';
  //   String newPreviewNameWithExtension = '${newGpxNameWithExtension.split('.').first}.jpg';

  //   if (tour.type == TourTypes.planned) {
  //     final dateRegExp = RegExp(r'\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}');
  //     if (!dateRegExp.hasMatch(tour.name)) {
  //       newPreviewNameWithExtension = '${tour.date}_$newPreviewNameWithExtension';
  //     }
  //   }

  //   await _changeFileNameOnly(gpxFile, newGpxNameWithExtension);

  //   await _changeFileNameOnly(previewfile, newPreviewNameWithExtension);
  // }

  String get _tracksDirectoryPath => "${_documentsDirectory!.path}/Data/Tracks";
  String get _tracksPreviewPath => "${_documentsDirectory!.path}/Tours/previews";
  String get _plannedTracksDirectoryPath => "${_documentsDirectory!.path}/Data/PlannedTracks";

  Future<Uint8List?> _readPreviewForGPX(String name) async {
    final previewPath = '$_tracksPreviewPath/$name'.replaceAll('gpx', 'jpg');

    final previewfile = File(previewPath);

    final doesFileExist = await previewfile.exists();

    if (doesFileExist) {
      return previewfile.readAsBytes();
    }

    return null;
  }

  // Future<void> _changeFileNameOnly(File file, String newFileName) async {
  //   if (!(await file.exists())) return;
  //   var path = file.path;

  //   var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
  //   var newPath = path.substring(0, lastSeparator + 1) + newFileName;
  //   file.rename(newPath);
  // }

  Future<void> _ensureDirectoryIsCreated(String path) async {
    if (_documentsDirectory == null) {
      if (io.Platform.isAndroid) {
        _documentsDirectory = await getExternalStorageDirectory();
      } else if (io.Platform.isIOS) {
        _documentsDirectory = await getApplicationDocumentsDirectory();
      }
    }

    final previewsDirectory = Directory(path);

    if (!(await previewsDirectory.exists())) {
      await previewsDirectory.create(recursive: true);
    }
  }

  // @override
  // Future<void> addTourPreview({required TourEntity tour, required Uint8List preview}) async {
  //   await _ensureDirectoryIsCreated(_tracksPreviewPath);
  //   File file = File(tour.getCorrespondingPreviewPath(_tracksPreviewPath));

  //   await file.writeAsBytes(preview);
  // }

  // @override
  // Future<void> shareAsGPX(TourEntity tour) async {
  //   await Share.shareXFiles([XFile(tour.filePath)]);
  // }

  // @override
  // void registerForIncomingGPXIntents(void Function(TourEntity tour) onTourReceived) {
  //   ReceiveSharingIntent.instance.getMediaStream().listen((value) async {
  //     if (value.isEmpty) return;
  //     final importedFile = value.first;

  //     final tour = await TourBuilder.build(File(importedFile.path));
  //     if (tour == null) return;

  //     onTourReceived(tour);
  //   }, onError: (err) {});

  //   ReceiveSharingIntent.instance.getInitialMedia().then((value) async {
  //     if (value.isEmpty) return;
  //     final importedFile = value.first;

  //     final tour = await TourBuilder.build(File(importedFile.path));

  //     if (tour == null) return;
  //     ReceiveSharingIntent.instance.reset();
  //   });
  // }

  // @override
  // Future<void> saveTour(TourEntity tour) async {
  //   final tempfile = File(tour.filePath);
  //   await tempfile.copy('$_tracksDirectoryPath/${tour.name}');
  // }

  // @override
  // Future<TourEntity?> addPlannedTour(RouteEntity route, String name) async {
  //   await _ensureDirectoryIsCreated(_plannedTracksDirectoryPath);

  //   final timestamp = DateTime.now().toIso8601String();
  //   String folderFileName = 'Planned_Tour_$timestamp';

  //   final directory = Directory('$_plannedTracksDirectoryPath/$folderFileName');
  //   if (!await directory.exists()) {
  //     await directory.create(recursive: true);
  //   }

  //   final gpxFileName = '$folderFileName/$name';
  //   final fileCompletePath = join(_plannedTracksDirectoryPath, '$gpxFileName.gpx');

  //   final gpxData = route.exportToGpx();
  //   String gpxString = utf8.decode(gpxData);

  //   Uint8List decodedGpxData = base64.decode(gpxString);

  //   io.File file = await io.File(fileCompletePath).create();
  //   file.writeAsBytes(decodedGpxData);

  //   final tours = await getPlannedTours();

  //   final lastRecordedTour = tours.firstWhere((tour) => tour.date == timestamp);

  //   return lastRecordedTour;
  // }

  // @override
  // Future<List<TourEntity>> getPlannedTours() async {
  //   await _ensureDirectoryIsCreated(_plannedTracksDirectoryPath);

  //   final io.Directory directory = io.Directory(_plannedTracksDirectoryPath);
  //   final List<io.FileSystemEntity> trackDirEntities = await directory.list().toList();

  //   final recordedTours = <TourEntity>[];

  //   for (final entity in trackDirEntities) {
  //     if (entity is! io.Directory) continue;

  //     final List<io.FileSystemEntity> filesInDir = await entity.list().toList();

  //     io.File? gpxFile;
  //     for (final file in filesInDir) {
  //       if (file is io.File && file.path.toLowerCase().endsWith('.gpx')) {
  //         gpxFile = file;
  //         break;
  //       }
  //     }
  //     if (gpxFile != null) {
  //       final preview = await _readPreviewForGPX(_getPreviewWithDate(gpxFile.path));
  //       final tour = await TourBuilder.build(gpxFile, preview: preview);
  //       if (tour == null) continue;
  //       recordedTours.add(tour);
  //     }
  //   }

  //   return recordedTours;
  // }

  // String _getPreviewWithDate(gpxFilePath) {
  //   String fileName = gpxFilePath.split('/').last;

  //   final dateRegExp = RegExp(r'\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+');
  //   String? dateMatch = dateRegExp.stringMatch(gpxFilePath);
  //   if (dateMatch == null) {
  //     throw Exception('Name of planned tour is not as it should be');
  //   }

  //   return '${dateMatch}_$fileName';
  // }

  // @override
  // Future<TourEntity?> importTour() async {
  //   final result = await fp.FilePicker.platform.pickFiles(
  //     type: Platform.isAndroid ? fp.FileType.any : fp.FileType.custom,
  //     allowedExtensions: Platform.isAndroid ? null : ['gpx'],
  //   );

  //   if (result == null) return null;
  //   if (result.files.isEmpty) return null;
  //   if (result.files.first.extension != 'gpx') return null;

  //   final pickedFile = result.files.first;
  //   return await TourBuilder.build(File(pickedFile.path!));
  // }
}
