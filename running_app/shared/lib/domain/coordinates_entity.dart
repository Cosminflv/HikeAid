import 'package:equatable/equatable.dart';

abstract class CoordinatesEntity extends Equatable {
  final double latitude;
  final double longitude;

  double getDistanceTo(CoordinatesEntity coords);
  const CoordinatesEntity({required this.latitude, required this.longitude});

  /// Helper method to round a double to the 7th decimal place
  // double _roundTo6Decimals(double value) {
  //   return (value * 1e6).roundToDouble() / 1e6;
  // }

  // bool isEqual(Object other) {
  //   if (other is CoordinatesEntity) {
  //     return _roundTo6Decimals(latitude) == _roundTo6Decimals(other.latitude) &&
  //         _roundTo6Decimals(longitude) == _roundTo6Decimals(other.longitude);
  //   }
  //   return false;
  // }

  static const double epsilon = 1e-6; // Adjust as needed

  bool isEqual(Object other) {
    if (other is CoordinatesEntity) {
      return (latitude - other.latitude).abs() < epsilon && (longitude - other.longitude).abs() < epsilon;
    }
    return false;
  }

  @override
  List<Object?> get props => [latitude, longitude];
}
