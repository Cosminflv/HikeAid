import 'package:domain/entities/landmark_entity.dart';

import 'package:equatable/equatable.dart';

class LandmarkStoreState extends Equatable {
  final List<LandmarkEntity> landmarks;

  const LandmarkStoreState({this.landmarks = const []});

  LandmarkStoreState copyWith({List<LandmarkEntity>? landmarks}) =>
      LandmarkStoreState(landmarks: landmarks ?? this.landmarks);

  @override
  List<Object?> get props => [landmarks];
}
