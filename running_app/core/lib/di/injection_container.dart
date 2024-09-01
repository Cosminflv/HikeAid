import 'package:data/repositories_impl/authentication_repository_impl.dart';
import 'package:data/repositories_impl/registration__repository_impl.dart';
import 'package:domain/repositories/authentication_repository.dart';
import 'package:domain/repositories/registration_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:openapi/openapi.dart';
import 'package:running_app/location/location_bloc.dart';

final sl = GetIt.instance;

initBlocs() {
  sl.registerLazySingleton<LocationBloc>(() => LocationBloc());
}

discardBlocsIfRegistered() {
  sl.get<LocationBloc>().close();
}

initEarlyDependencies() {
  sl.allowReassignment = true;
  final openApi = Openapi();

  //Onboarding
  sl.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(openApi.getUserApi()));
  sl.registerLazySingleton<RegistrationRepository>(() => RegistrationRepositoryImpl(openApi.getUserApi()));
}
