import 'package:data/repositories_impl/internet_connection_repository_impl.dart';
import 'package:data/repositories_impl/landmark_store_repository_impl.dart';
import 'package:data/repositories_impl/onboarding_repository_impl.dart';
import 'package:data/repositories_impl/camera_repository_impl.dart';
import 'package:data/repositories_impl/map_repository_impl.dart';
import 'package:data/repositories_impl/permission_repository_impl.dart';
import 'package:data/repositories_impl/position_repository_impl.dart';
import 'package:data/repositories_impl/search_repository_impl.dart';
import 'package:data/repositories_impl/user_profile_repository_impl.dart';
import 'package:data/utils/map_widget_builder_impl.dart';
import 'package:domain/entities/landmark_store_entity.dart';
import 'package:domain/map_widget_builder.dart';
import 'package:domain/map_platform.dart';
import 'package:data/models/asset_bundle_entity_impl.dart';
import 'package:data/utils/map_platform_impl.dart';
import 'package:domain/repositories/camera_repository.dart';
import 'package:domain/repositories/internet_connection_repository.dart';
import 'package:domain/repositories/landmark_repository.dart';
import 'package:domain/repositories/landmark_store_repository.dart';
import 'package:domain/repositories/map_repository.dart';
import 'package:domain/repositories/onboarding_repository.dart';
import 'package:domain/repositories/permission_repository.dart';
import 'package:data/repositories_impl/landmark_repository_impl.dart';
import 'package:data/repositories_impl/search_user_repository_impl.dart';
import 'package:domain/repositories/position_repository.dart';
import 'package:domain/repositories/search_repository.dart';
import 'package:domain/repositories/search_users_repository.dart';
import 'package:domain/repositories/user_profile_repository.dart';
import 'package:domain/use_cases/authentication_session_use_case.dart';
import 'package:domain/use_cases/authentication_use_case.dart';
import 'package:domain/use_cases/internet_connection_use_case.dart';
import 'package:domain/use_cases/landmark_store_use_case.dart';
import 'package:domain/use_cases/landmark_use_case.dart';
import 'package:domain/use_cases/location_use_case.dart';
import 'package:domain/use_cases/map_use_case.dart';
import 'package:domain/use_cases/search_use_case.dart';
import 'package:domain/use_cases/search_users_use_case.dart';
import 'package:domain/use_cases/user_profile_use_case.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_bloc.dart';
import 'package:running_app/internet_connection/internet_connection_bloc.dart';
import 'package:running_app/landmark_store/landmark_store_bloc.dart';
import 'package:running_app/onboarding/auth_session/auth_session_bloc.dart';
import 'package:running_app/onboarding/authentication/authentication_view_bloc.dart';
import 'package:running_app/onboarding/registration/registration_view_bloc.dart';
import 'package:running_app/location/location_bloc.dart';
import 'package:running_app/map/map_view_bloc.dart';
import 'package:running_app/app/app_bloc.dart';
import 'package:domain/map_controller.dart';

import 'package:openapi/openapi.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/io.dart';
import 'package:dio/dio.dart';
import 'package:running_app/search/search_menu_bloc.dart';
import 'package:running_app/search_users/search_users_view_bloc.dart';
import 'dart:io';

import 'package:running_app/user_profile/user_profile_view_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final sl = GetIt.instance;

initBlocs() {
  sl.registerLazySingleton<LocationBloc>(() => LocationBloc());
  sl.registerLazySingleton<LandmarkStoreBloc>(() => LandmarkStoreBloc(DLandmarkStoreType.searchHistory),
      instanceName: DLandmarkStoreType.searchHistory.name);
  sl.registerLazySingleton<MapViewBloc>(() => MapViewBloc(AssetBundleEntityImpl()));
}

discardBlocsIfRegistered() {
  sl.get<MapViewBloc>().close();

  sl.unregister<MapViewBloc>();
}

initEarlyDependencies() {
  Dio dio = Dio(BaseOptions(baseUrl: "https://192.168.1.3:7011/", connectTimeout: Duration(seconds: 10)));
  // ignore: deprecated_member_use
  (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  };

  dio.options.validateStatus = (status) {
    // Allow all status codes from 200 to 499 as valid
    return status != null && status >= 200 && status < 500;
  };

  final openApi = Openapi(dio: dio, interceptors: [BearerAuthInterceptor()]);

  final storage = FlutterSecureStorage();

  sl.allowReassignment = true;

  sl.registerLazySingleton<FlutterSecureStorage>(() => storage);

  //Repositories
  sl.registerLazySingleton<PositionRepository>(() => PositionRepositoryImpl());
  sl.registerLazySingleton<PermissionRepository>(() => PermissionRepositoryImpl());
  sl.registerLazySingleton<OnboardingRepository>(() => OnboardingRepositoryImpl(openApi, storage));
  sl.registerLazySingleton<LandmarkRepository>(() => LandmarkRepositoryImpl());
  sl.registerLazySingleton<SearchUsersRepository>(() => SearchUserRepositoryImpl(openApi));
  sl.registerLazySingleton<UserProfileRepository>(() => UserProfileRepositoryImpl(openApi));
  sl.registerLazySingleton<SearchRepository>(() => SearchRepositoryImpl());
  sl.registerLazySingleton<LandmarkStoreRepository>(() => LandmarkStoreRepositoryImpl());
  sl.registerLazySingleton<InternetConnectionRepository>(() => InternetConnectionRepositoryImpl());

  sl.registerLazySingleton<MapWidgetBuilder>(() => MapWidgetBuilderImpl());
  //Usecases
  sl.registerLazySingleton<OnboardingUseCase>(() => OnboardingUseCase(sl.get<OnboardingRepository>()));
  sl.registerLazySingleton<LocationUseCase>(
      () => LocationUseCase(sl.get<PermissionRepository>(), sl.get<PositionRepository>()));
  sl.registerLazySingleton<LandmarkUseCase>(() => LandmarkUseCase(sl.get<LandmarkRepository>()));
  sl.registerLazySingleton<UserProfileUseCase>(() => UserProfileUseCase(sl.get<UserProfileRepository>()));
  sl.registerLazySingleton<AuthenticationSessionUseCase>(
      () => AuthenticationSessionUseCase(sl.get<OnboardingRepository>()));
  sl.registerLazySingleton<SearchUsersUseCase>(() => SearchUsersUseCase(sl.get<SearchUsersRepository>()));
  sl.registerLazySingleton<SearchUseCase>(() => SearchUseCase(sl.get<SearchRepository>()));
  sl.registerLazySingleton<LandmarkStoreUseCase>(() => LandmarkStoreUseCase(sl.get<LandmarkStoreRepository>()));
  sl.registerLazySingleton<InternetConnectionUseCase>(
      () => InternetConnectionUseCase(sl.get<InternetConnectionRepository>()));

  //Blocs
  sl.registerLazySingleton<AuthenticationViewBloc>(() => AuthenticationViewBloc());
  sl.registerLazySingleton<RegistrationViewBloc>(() => RegistrationViewBloc());
  sl.registerLazySingleton<MapViewBloc>(() => MapViewBloc(AssetBundleEntityImpl()));
  sl.registerLazySingleton<LocationBloc>(() => LocationBloc());
  sl.registerLazySingleton<AppBloc>(() => AppBloc());
  sl.registerLazySingleton<UserProfileBloc>(() => UserProfileBloc());
  sl.registerLazySingleton<AuthSessionBloc>(() => AuthSessionBloc());
  sl.registerLazySingleton<EditUserProfileViewBloc>(() => EditUserProfileViewBloc());
  sl.registerLazySingleton<SearchUsersBloc>(() => SearchUsersBloc());
  sl.registerLazySingleton<SearchMenuBloc>(() => SearchMenuBloc());
  sl.registerLazySingleton<InternetConnectionBloc>(() => InternetConnectionBloc());

  sl.registerLazySingleton<MapPlatform>(() => MapPlatformImpl());
}

initMapDependecies(MapController controller, {String? instanceName}) async {
  sl.registerLazySingleton<MapRepository>(() => MapRepositoryImpl(controller), instanceName: instanceName);
  sl.registerLazySingleton<CameraRepository>(() => CameraRepositoryImpl(controller));

  sl.registerLazySingleton<MapUseCase>(
      () => MapUseCase(
            sl.get<MapRepository>(instanceName: instanceName),
            sl.get<CameraRepository>(),
          ),
      instanceName: instanceName);
}
