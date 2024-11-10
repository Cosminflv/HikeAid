abstract class ViewUserProfileViewEvent {}

class FetchUserProfileEvent extends ViewUserProfileViewEvent {
  final int userId;

  FetchUserProfileEvent(this.userId);
}
