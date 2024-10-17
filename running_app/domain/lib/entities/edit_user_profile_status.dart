abstract class EditUserProfileStatus {}

enum EditUserFailType { userNotFound, noConnection, timeout, other }

class EditStarted extends EditUserProfileStatus {}

class EditInProgress extends EditUserProfileStatus {}

class EditFailed extends EditUserProfileStatus {
  EditUserFailType reason;

  EditFailed({this.reason = EditUserFailType.other});
}

class EditSuccess extends EditUserProfileStatus {}

extension EditFailTypeExtension on EditUserFailType {
  String get description {
    switch (this) {
      case EditUserFailType.timeout:
        return "Request timed out";
      case EditUserFailType.noConnection:
        return "No internet connection";
      case EditUserFailType.other:
        return "An unknown error occurred";
      case EditUserFailType.userNotFound:
        return "User not found";
      default:
        return "An unknown error occurred"; // This case should not occur, but it's good to have a fallback.
    }
  }
}
