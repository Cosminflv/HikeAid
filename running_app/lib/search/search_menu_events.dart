import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/entities/landmark_category_entity.dart';
import 'package:domain/entities/landmark_entity.dart';
import 'package:domain/entities/landmark_with_distance_entity.dart';
import 'package:domain/entities/search_status.dart';

abstract class SearchMenuEvent {}

class SearchTextEvent extends SearchMenuEvent {
  final String text;
  final CoordinatesEntity coordinates;

  SearchTextEvent({required this.text, required this.coordinates});
}

class SearchCategoryEvent extends SearchMenuEvent {
  final LandmarkCategoryEntity category;
  final CoordinatesEntity coordinates;

  SearchCategoryEvent({required this.category, required this.coordinates});
}

class SearchSuccessfulEvent extends SearchMenuEvent {
  final List<LandmarkWithDistanceEntity> results;

  SearchSuccessfulEvent(this.results);
}

class SearchStatusUpdatedEvent extends SearchMenuEvent {
  final SearchStatus status;

  SearchStatusUpdatedEvent(this.status);
}

class ResultSelectedEvent extends SearchMenuEvent {
  LandmarkEntity? result;

  ResultSelectedEvent({required this.result});
}

class ClearSearchEvent extends SearchMenuEvent {}
