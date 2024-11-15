abstract class UserProfileEvent {}

class FetchUserProfileEvent extends UserProfileEvent {
  final int userId;

  FetchUserProfileEvent({required this.userId});
}
