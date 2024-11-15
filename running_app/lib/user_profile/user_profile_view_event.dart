import 'package:domain/entities/auth_session_entity.dart';

abstract class UserProfileEvent {}

class FetchUserProfileEvent extends UserProfileEvent {
  final AuthSessionEntity? session; // For authenticated user.
  final int? userId; // For viewing another user's profile.

  FetchUserProfileEvent({this.session, this.userId});
}
