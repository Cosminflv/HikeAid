

import 'package:domain/entities/landmark_category_entity.dart';
import 'package:domain/entities/landmark_entity.dart';
import 'package:domain/entities/landmark_with_distance_entity.dart';
import 'package:domain/entities/search_status.dart';

import 'package:equatable/equatable.dart';

class SearchMenuState extends Equatable {
  final List<LandmarkWithDistanceEntity> results;
  final SearchStatus status;
  final LandmarkCategoryEntity? selectedLandmarkCategory;
  final LandmarkEntity? selectedLandmark;

  const SearchMenuState(
      {this.results = const [], this.selectedLandmark, this.status = SearchStatus.none, this.selectedLandmarkCategory});

  SearchMenuState copyWith(
          {List<LandmarkWithDistanceEntity>? results,
          SearchStatus? status,
          LandmarkEntity? selectedLandmark,
          LandmarkWithDistanceEntity? homeLandmark,
          LandmarkWithDistanceEntity? workLandmark,
          LandmarkCategoryEntity? selectedLandmarkCategory}) =>
      SearchMenuState(
        results: results ?? this.results,
        status: status ?? this.status,
        selectedLandmark: selectedLandmark ?? this.selectedLandmark,
        selectedLandmarkCategory: selectedLandmarkCategory ?? this.selectedLandmarkCategory,
      );

  SearchMenuState copyWithNullLandmarkCategory() => SearchMenuState(
        results: results,
        status: status,
        selectedLandmarkCategory: null,
      );

  SearchMenuState copyWithNullSelectedLandmark() => SearchMenuState(
        results: results,
        status: status,
        selectedLandmark: null,
        selectedLandmarkCategory: selectedLandmarkCategory,
      );

  @override
  List<Object?> get props => [results, status, selectedLandmarkCategory, selectedLandmark];
}
