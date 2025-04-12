import 'package:shared/domain/landmark_entity.dart';
import 'package:domain/entities/landmark_with_distance_entity.dart';
import 'package:domain/entities/search_status.dart';

import 'package:equatable/equatable.dart';

class SearchMenuState extends Equatable {
  final List<LandmarkWithDistanceEntity> results;
  final SearchStatus status;
  final LandmarkEntity? selectedLandmark;

  const SearchMenuState({this.results = const [], this.selectedLandmark, this.status = SearchStatus.none});

  SearchMenuState copyWith({
    List<LandmarkWithDistanceEntity>? results,
    SearchStatus? status,
    LandmarkEntity? selectedLandmark,
    LandmarkWithDistanceEntity? homeLandmark,
    LandmarkWithDistanceEntity? workLandmark,
  }) =>
      SearchMenuState(
        results: results ?? this.results,
        status: status ?? this.status,
        selectedLandmark: selectedLandmark ?? this.selectedLandmark,
      );

  SearchMenuState copyWithNullSelectedLandmark() => SearchMenuState(
        results: results,
        status: status,
        selectedLandmark: null,
      );

  @override
  List<Object?> get props => [results, status, selectedLandmark];
}
