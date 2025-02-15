import 'package:domain/entities/local_map_style_entity.dart';
import 'package:domain/repositories/content_store_repository.dart';

class ContentStoreUseCase {
  final ContentStoreRepository _repository;

  ContentStoreUseCase(this._repository);

  Future<List<LocalMapStyleEntity>> getAvailableLocalStyles() async => await _repository.getAvailableLocalStyles();
}
