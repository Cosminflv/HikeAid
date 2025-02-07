import 'package:domain/entities/alert_entity.dart';
import 'package:gem_kit/core.dart';

class AlertEntityImpl extends AlertEntity {
  AlertEntityImpl(
      {required super.id,
      required super.title,
      required super.description,
      required super.createdAt,
      required super.expiresAt,
      required super.isActive,
      required super.coordinates,
      required super.alertType,
      required super.authorId,
      required super.image,
      required super.authorName,
      required super.confirmationsNumber});

  Coordinates toGemCoordinates() => Coordinates(latitude: coordinates.latitude, longitude: coordinates.longitude);
}
