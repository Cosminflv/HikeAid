import 'package:domain/entities/auth_session_entity.dart';

abstract class UserProfileViewEvent {}

class FetchUserProfileEvent extends UserProfileViewEvent {
  final AuthSessionEntity? session;

  FetchUserProfileEvent(this.session);
}
