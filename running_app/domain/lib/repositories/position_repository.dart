import 'package:domain/entities/position_entity.dart';

/// A repository interface for managing and accessing positional data.
///
/// This repository provides functionality to retrieve and monitor the user's current position
/// through streams and direct queries. It also allows for setting live positions and managing
/// position listeners.
abstract class PositionRepository {
  /// A stream that continuously provides updates on the user's position.
  ///
  /// - Returns: A [Stream] of [PositionEntity?] that emits the current position whenever
  ///   it changes. If no position is available, it emits `null`.
  /// - Usage:
  ///   Subscribe to this stream to receive real-time updates about the user's location.
  Stream<PositionEntity?> get positionStream;

  /// Retrieves the user's current position.
  ///
  /// - Returns: A [PositionEntity?] representing the user's current position, or `null`
  ///   if no position is available.
  PositionEntity? get position;

  /// Activates live position tracking to continuously update the user's location.
  ///
  /// - Returns: A [Future] that completes when live position tracking is successfully enabled.
  /// - Throws:
  ///   - [SomeSpecificException] if enabling live position tracking fails due to
  ///     permissions, connectivity, or other issues.
  Future<void> setLivePosition();

  /// Cancels the current position listener and stops tracking updates.
  ///
  /// - Throws:
  ///   - [SomeSpecificException] if the listener cannot be canceled.
  void cancelPositionListener();
}
