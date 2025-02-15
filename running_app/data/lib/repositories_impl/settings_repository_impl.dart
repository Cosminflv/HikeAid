import 'package:data/models/camera_state_entity_impl.dart';
import 'package:data/models/coordinates_entity_impl.dart';
import 'package:domain/entities/camera_state_entity.dart';
import 'package:domain/repositories/settings_repository.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:convert';

class SettingsRepositoryImpl extends SettingsRepository {
  late SharedPreferences _sharedPreferences;

  SettingsRepositoryImpl() {
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  @override
  Future<void> initSettings() async {
    await Hive.initFlutter();
    await Hive.openBox('camera');
    await Hive.openBox<List<int>>('searchActions');
  }

  @override
  MapCameraStateEntity getSavedCameraState() {
    final box = Hive.box('camera');

    final mapCameraJsonStr = box.get('savedScreenCenterCoords') as String?;
    if (mapCameraJsonStr == null) {
      return MapCameraStateEntityImpl(coordinates: CoordinatesEntityImpl(latitude: 46.7, longitude: 8.7), zoom: 40);
    }

    final mapCameraStateJson = jsonDecode(mapCameraJsonStr);

    return MapCameraStateEntityImpl.fromJson(mapCameraStateJson);
  }

  @override
  Future<void> saveCameraState(MapCameraStateEntity cameraState) async {
    cameraState as MapCameraStateEntityImpl;

    final cameraStateJsonStr = jsonEncode(cameraState.toJson());

    final box = Hive.box('camera');
    await box.put('savedScreenCenterCoords', cameraStateJsonStr);
  }

  @override
  Future<void> savePrefferedMapStylePath(String path) => _sharedPreferences.setString('mapStylePath', path);

  @override
  String getSavedPrefferedMapStylePath() => _sharedPreferences.getString('mapStylePath') ?? ' ';
}
