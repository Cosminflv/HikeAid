abstract class UserProfileEvent {}

class FetchUserProfileEvent extends UserProfileEvent {
  final int userId;

  FetchUserProfileEvent({required this.userId});
}

class FetchUserTours extends UserProfileEvent {
  final int userId;

  FetchUserTours({required this.userId});
}
