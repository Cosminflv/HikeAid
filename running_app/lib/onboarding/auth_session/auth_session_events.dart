import 'package:domain/entities/auth_session_entity.dart';

abstract class AuthSessionEvent {}

class AuthSessionUpdatedEvent extends AuthSessionEvent {
  final AuthSessionEntity? session;

  AuthSessionUpdatedEvent(this.session);
}

class CheckForSessionEvent extends AuthSessionEvent {}

class LogoutEvent extends AuthSessionEvent {}

class UpdateSessionInfoEvent extends AuthSessionEvent {
  final bool? hasCompletedProfile;

  UpdateSessionInfoEvent({this.hasCompletedProfile});
}
