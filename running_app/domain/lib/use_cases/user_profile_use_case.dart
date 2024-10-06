import 'package:domain/entities/auth_session_entity.dart';
import 'package:domain/entities/user_profile_entity.dart';
import 'package:domain/repositories/user_profile_repository.dart';

class UserProfileUseCase {
  final UserProfileRepository _userProfileRepository;

  UserProfileUseCase(this._userProfileRepository);

  Future<UserProfileEntity?> getAuthenticatedUserProfile(AuthSessionEntity session) async {
    final user = await _userProfileRepository.getAuthenticatedUserProfile(session);
    return user;
  }
}
