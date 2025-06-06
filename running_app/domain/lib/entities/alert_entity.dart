import 'package:equatable/equatable.dart';

import 'dart:typed_data';

import 'package:shared/domain/coordinates_entity.dart';

enum EAlertType {
  dangerousWeather,
  wildAnimals,
  roadBlock,
  personalEmergency,
  other;

  /// Convert an enum value to a short string
  String toFormattedString() {
    switch (this) {
      case EAlertType.personalEmergency:
        return 'Personal Emergency';
      case EAlertType.wildAnimals:
        return 'Wild Animals';
      case EAlertType.dangerousWeather:
        return 'Dangerous Weather';
      case EAlertType.roadBlock:
        return 'Road Block';
      case EAlertType.other:
        return 'Other';
    }
  }

  /// Convert a string to an enum value
  static EAlertType fromInt(int value) {
    return EAlertType.values.firstWhere(
      (e) => e.index == value,
      orElse: () => throw ArgumentError('Invalid alert type: $value'),
    );
  }
}

extension EAlertTypeExtension on EAlertType {
  String get alertIconName {
    switch (this) {
      case EAlertType.personalEmergency:
        return 'assets/personal_emergency_alert.png';
      case EAlertType.wildAnimals:
        return 'assets/wild_animals_alert.png';
      case EAlertType.dangerousWeather:
        return 'assets/weather_alert.png';
      case EAlertType.roadBlock:
        return 'assets/road_block_alert.png';
      case EAlertType.other:
        return 'assets/poi83.png';
    }
  }

  String get defaultAlertIcon => 'assets/poi83.png';
}

abstract class AlertEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime expiresAt;
  final bool isActive;
  final CoordinatesEntity coordinates;
  final EAlertType type;
  final int authorId;
  final String authorName;
  final int? confirmationsNumber;
  final Uint8List? image;

  AlertEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.createdAt,
      required this.expiresAt,
      required this.isActive,
      required this.coordinates,
      required this.type,
      required this.authorId,
      required this.authorName,
      required this.confirmationsNumber,
      this.image});

  Future<Uint8List?> loadImage();
  Future<int> loadConfirmationsNumber();

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        createdAt,
        expiresAt,
        isActive,
        coordinates,
        type,
        image,
        authorId,
        authorName,
        confirmationsNumber
      ];
}
