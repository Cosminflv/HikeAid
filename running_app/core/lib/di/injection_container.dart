import 'package:data/repositories_impl/authentication_repository_impl.dart';
import 'package:domain/repositories/onboarding_repository.dart';
import 'package:domain/use_cases/authentication_usecase.dart';
import 'package:running_app/onboarding/authentication/authentication_view_bloc.dart';
import 'package:running_app/onboarding/registration/registration_view_bloc.dart';
import 'package:running_app/location/location_bloc.dart';

import 'package:openapi/openapi.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/io.dart';
import 'package:dio/dio.dart';
import 'dart:io';

final sl = GetIt.instance;

initBlocs() {
  sl.registerLazySingleton<LocationBloc>(() => LocationBloc());
}

discardBlocsIfRegistered() {
  sl.get<LocationBloc>().close();
}

initEarlyDependencies() {
  Dio dio = Dio(BaseOptions(baseUrl: "https://192.168.1.6:7011/"));
  // ignore: deprecated_member_use
  (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  };

  dio.options.validateStatus = (status) {
    // Allow all status codes from 200 to 499 as valid
    return status != null && status >= 200 && status < 500;
  };
  final openApi = Openapi(dio: dio);

  sl.allowReassignment = true;

  //Onboarding
  sl.registerLazySingleton<OnboardingRepository>(() => OnboardingRepositoryImpl(openApi.getUserApi()));

  sl.registerLazySingleton<OnboardingUseCase>(() => OnboardingUseCase(sl.get<OnboardingRepository>()));

  sl.registerLazySingleton<AuthenticationViewBloc>(() => AuthenticationViewBloc());
  sl.registerLazySingleton<RegistrationViewBloc>(() => RegistrationViewBloc());
}
