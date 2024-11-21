import 'package:domain/entities/landmark_category_entity.dart';

import 'package:gem_kit/core.dart';

class LandmarkCategoryEntityImpl extends LandmarkCategoryEntity {
  final LandmarkCategory ref;

  LandmarkCategoryEntityImpl({super.icon, required super.id, required super.name, required this.ref});
}
