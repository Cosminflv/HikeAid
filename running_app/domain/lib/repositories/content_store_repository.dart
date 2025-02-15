import 'package:domain/entities/local_map_style_entity.dart';

abstract class ContentStoreRepository {
  Future<List<LocalMapStyleEntity>> getAvailableLocalStyles();
}
