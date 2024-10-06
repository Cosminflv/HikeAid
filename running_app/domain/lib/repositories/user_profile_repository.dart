import 'package:domain/entities/auth_session_entity.dart';
import 'package:domain/entities/user_profile_entity.dart';

abstract class UserProfileRepository {
  Future<UserProfileEntity?> getAuthenticatedUserProfile(AuthSessionEntity session);
}
