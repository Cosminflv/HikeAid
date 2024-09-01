import 'package:domain/entities/registration_status.dart';
import 'package:domain/repositories/registration_repository.dart';
import 'package:openapi/openapi.dart';

class RegistrationRepositoryImpl extends RegistrationRepository {
  final UserApi _userApi;

  RegistrationRepositoryImpl(this._userApi);
  @override
  Future<void> register(
      {required String username,
      required String password,
      required String firstName,
      required String lastName,
      required Function(RegistrationStatus p1) onRegistrationProgressUpdated}) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
