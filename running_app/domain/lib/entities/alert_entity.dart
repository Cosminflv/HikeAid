import 'package:domain/entities/coordinates_entity.dart';
import 'package:equatable/equatable.dart';

import 'dart:typed_data';

enum EAlertType { dangerousWeather, wildAnimals, roadBlock, personalEmergency, other }

extension EAlertTypeExtension on EAlertType {
  String toShortString() {
    return toString().split('.').last;
  }

  static EAlertType fromString(String value) {
    return EAlertType.values.firstWhere((e) => e.toShortString() == value);
  }
}

abstract class AlertEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime expiresAt;
  final bool isActive;
  final CoordinatesEntity coordinates;
  final EAlertType alertType;
  final int authorId;
  final int confirmationsNumber;
  final String authorName;
  final Uint8List? image;

  AlertEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.createdAt,
      required this.expiresAt,
      required this.isActive,
      required this.coordinates,
      required this.alertType,
      required this.authorId,
      required this.authorName,
      required this.confirmationsNumber,
      this.image});

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        createdAt,
        expiresAt,
        isActive,
        coordinates,
        alertType,
        image,
        authorId,
        authorName,
        confirmationsNumber
      ];
}
