abstract class Failure {}

class ContentStoreFailure extends Failure {}

class RoutingFailure extends Failure {}

enum RouteError { routeTooLong, invalidInput, canceled, general }

RouteError getRouteErrorFromGemError(int gemErrorCode) {
  switch (gemErrorCode) {
    case -20:
      return RouteError.routeTooLong;
    case -15:
      return RouteError.invalidInput;
    case -3:
      return RouteError.canceled;
    case -1:
    default:
      return RouteError.general;
  }
}
