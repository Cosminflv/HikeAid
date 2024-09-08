import 'package:equatable/equatable.dart';

class MapViewState extends Equatable {
  final bool isMapCreated;

  const MapViewState({
    this.isMapCreated = false,
  });

  MapViewState copyWith({
    bool? isMapCreated,
  }) =>
      MapViewState(
        isMapCreated: isMapCreated ?? this.isMapCreated,
      );

  @override
  List<Object?> get props => [isMapCreated];
}
