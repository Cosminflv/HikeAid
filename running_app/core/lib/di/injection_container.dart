import 'package:core/di/app_blocs.dart';
import 'package:data/repositories_impl/friendship_repository_impl.dart';
import 'package:data/repositories_impl/image_cache_repository_impl.dart';
import 'package:data/repositories_impl/internet_connection_repository_impl.dart';
import 'package:data/repositories_impl/landmark_store_repository_impl.dart';
import 'package:data/repositories_impl/navigation_repository_impl.dart';
import 'package:data/repositories_impl/onboarding_repository_impl.dart';
import 'package:data/repositories_impl/camera_repository_impl.dart';
import 'package:data/repositories_impl/map_repository_impl.dart';
import 'package:data/repositories_impl/pending_alerts_repository_impl.dart';

import 'package:data/repositories_impl/position_repository_impl.dart';
import 'package:data/repositories_impl/recorder_repository_impl.dart';
import 'package:data/repositories_impl/route_repository_impl.dart';
import 'package:data/repositories_impl/search_repository_impl.dart';
import 'package:data/repositories_impl/settings_repository_impl.dart';
import 'package:data/repositories_impl/tts_repository_impl.dart';
import 'package:data/repositories_impl/user_profile_repository_impl.dart';
import 'package:data/repositories_impl/tour_repository_impl.dart';
import 'package:data/utils/map_widget_builder_impl.dart';
import 'package:data/factories/landmark_factory_impl.dart';
import 'package:data/factories/path_factory_impl.dart';

import 'package:domain/entities/landmark_store_entity.dart';
import 'package:domain/entities/view_area_entity.dart';
import 'package:domain/map_widget_builder.dart';
import 'package:domain/map_platform.dart';
import 'package:data/models/asset_bundle_entity_impl.dart';
import 'package:data/utils/map_platform_impl.dart';
import 'package:domain/repositories/alert_repository.dart';
import 'package:domain/repositories/camera_repository.dart';
import 'package:domain/repositories/content_store_repository.dart';
import 'package:domain/repositories/friendship_repository.dart';
import 'package:domain/repositories/image_cache_repository.dart';
import 'package:domain/repositories/internet_connection_repository.dart';
import 'package:domain/repositories/landmark_repository.dart';
import 'package:domain/repositories/landmark_store_repository.dart';
import 'package:domain/repositories/map_repository.dart';
import 'package:domain/repositories/navigation_repository.dart';
import 'package:domain/repositories/onboarding_repository.dart';
import 'package:domain/repositories/position_prediction_repository.dart';
import 'package:domain/repositories/pending_alerts_repository.dart';
import 'package:data/repositories_impl/landmark_repository_impl.dart';
import 'package:data/repositories_impl/search_user_repository_impl.dart';
import 'package:domain/repositories/position_repository.dart';
import 'package:domain/repositories/recorder_repository.dart';
import 'package:domain/repositories/route_repository.dart';
import 'package:domain/repositories/search_repository.dart';
import 'package:domain/repositories/search_users_repository.dart';
import 'package:domain/repositories/settings_repository.dart';
import 'package:domain/repositories/tour_repository.dart';
import 'package:domain/repositories/tts_repository.dart';
import 'package:domain/repositories/user_profile_repository.dart';
import 'package:data/repositories_impl/alert_repository_impl.dart';
import 'package:data/repositories_impl/content_store_repository_impl.dart';
import 'package:data/repositories_impl/position_prediction_repository_impl.dart';
import 'package:domain/use_cases/alert_use_case.dart';

import 'package:domain/use_cases/authentication_session_use_case.dart';
import 'package:domain/use_cases/authentication_use_case.dart';
import 'package:domain/use_cases/content_store_use_case.dart';
import 'package:domain/use_cases/internet_connection_use_case.dart';
import 'package:domain/use_cases/landmark_store_use_case.dart';
import 'package:domain/use_cases/landmark_use_case.dart';
import 'package:domain/use_cases/location_use_case.dart';
import 'package:domain/use_cases/friendship_use_case.dart';
import 'package:domain/use_cases/map_use_case.dart';
import 'package:domain/use_cases/navigation_use_case.dart';
import 'package:domain/use_cases/pending_alerts_use_case.dart';
import 'package:domain/use_cases/recorder_use_case.dart';
import 'package:domain/use_cases/routing_use_case.dart';
import 'package:domain/use_cases/search_use_case.dart';
import 'package:domain/use_cases/search_users_use_case.dart';
import 'package:domain/use_cases/settings_use_case.dart';
import 'package:domain/use_cases/tour_use_case.dart';
import 'package:domain/use_cases/user_profile_use_case.dart';
import 'package:domain/use_cases/position_prediction_use_case.dart';
import 'package:domain/factories/landmark_factory.dart';
import 'package:domain/factories/path_factory.dart';
import 'package:running_app/alerts/alert_bloc.dart';

import 'package:running_app/edit_user_profile/edit_user_profile_view_bloc.dart';
import 'package:running_app/home/home_view_bloc.dart';
import 'package:running_app/internet_connection/device_info_bloc.dart';
import 'package:running_app/landmark_store/landmark_store_bloc.dart';
import 'package:running_app/map_styles/map_styles_panel_bloc.dart';
import 'package:running_app/navigation/navigation_view_bloc.dart';
import 'package:running_app/friendships/friendships_view_bloc.dart';
import 'package:running_app/navigation_instructions/navigation_instructions_panel_bloc.dart';
import 'package:running_app/onboarding/auth_session/auth_session_bloc.dart';
import 'package:running_app/onboarding/authentication/authentication_view_bloc.dart';
import 'package:running_app/onboarding/registration/registration_view_bloc.dart';
import 'package:running_app/location/location_bloc.dart';
import 'package:running_app/map/map_view_bloc.dart';
import 'package:running_app/app/app_bloc.dart';
import 'package:running_app/position_prediction/position_prediction_bloc.dart';
import 'package:running_app/route_terrain_profile/route_profile_panel_bloc.dart';
import 'package:running_app/settings/content_store_view/content_store_bloc.dart';
import 'package:running_app/settings/settings_view_bloc.dart';
import 'package:running_app/settings/settings_view_events.dart';
import 'package:running_app/user_profile/user_profile_view_bloc.dart';
import 'package:running_app/routing/routing_view_bloc.dart';
import 'package:running_app/search/search_menu_bloc.dart';
import 'package:running_app/search_users/search_users_view_bloc.dart';
import 'package:running_app/tour_recording/tour_recording_bloc.dart';
import 'package:domain/map_controller.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:openapi/openapi.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared/data/permission_repository_impl.dart';
import 'package:shared/domain/permission_repository.dart';
import 'package:shared/factories/tour_factory.dart';
import 'package:shared/factories/tour_factory_impl.dart';

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';

final sl = GetIt.instance;

initBlocs() {
  sl.registerLazySingleton<LocationBloc>(() => LocationBloc());

  sl.registerSingleton<SettingsViewBloc>(SettingsViewBloc());
  sl.registerLazySingleton<LandmarkStoreBloc>(() => LandmarkStoreBloc(DLandmarkStoreType.searchHistory),
      instanceName: DLandmarkStoreType.searchHistory.name);
  sl.registerLazySingleton<MapViewBloc>(() => MapViewBloc(AssetBundleEntityImpl()));

  AppBlocs.settingsViewBloc.add(LoadSettingsEvent());
}

discardBlocsIfRegistered() {
  if (!sl.isRegistered<SettingsViewBloc>()) {
    return;
  }

  AppBlocs.mapBloc.close();
  AppBlocs.settingsViewBloc.close();

  sl.unregister<MapViewBloc>();
  sl.unregister<SettingsViewBloc>();
}

initEarlyDependencies(String ipv4Address) async {
  Dio dio = Dio(BaseOptions(baseUrl: "http://$ipv4Address:7011/", connectTimeout: Duration(seconds: 10)));

  dio.options.validateStatus = (status) {
    // Allow all status codes from 200 to 499 as valid
    return status != null && status >= 200 && status < 500;
  };

  final openApi = Openapi(dio: dio, interceptors: [BearerAuthInterceptor()]);

  final storage = FlutterSecureStorage();
  CloudinaryContext.cloudinary = Cloudinary.fromCloudName(cloudName: 'desccolsj');

  sl.allowReassignment = true;

  // Misc
  sl.registerLazySingleton<FlutterSecureStorage>(() => storage);
  sl.registerLazySingleton<ContentStoreRepository>(() => ContentStoreRepositoryImpl(sl.get<ImageCacheRepository>()));
  sl.registerSingleton<SettingsRepository>(SettingsRepositoryImpl());

  sl.registerLazySingleton<SettingsUseCase>(() => SettingsUseCase(sl.get<SettingsRepository>()));
  sl.registerLazySingleton<ContentStoreUseCase>(() => ContentStoreUseCase(sl.get<ContentStoreRepository>()));

  // Repositories
  sl.registerLazySingleton<PositionRepository>(() => PositionRepositoryImpl());
  sl.registerLazySingleton<PermissionRepository>(() => PermissionRepositoryImpl());
  sl.registerLazySingleton<OnboardingRepository>(() => OnboardingRepositoryImpl(openApi, storage));
  sl.registerLazySingleton<LandmarkRepository>(() => LandmarkRepositoryImpl());
  sl.registerLazySingleton<SearchUsersRepository>(() => SearchUserRepositoryImpl(openApi));
  sl.registerLazySingleton<UserProfileRepository>(() => UserProfileRepositoryImpl(openApi));
  sl.registerLazySingleton<SearchRepository>(() => SearchRepositoryImpl());
  sl.registerLazySingleton<LandmarkStoreRepository>(() => LandmarkStoreRepositoryImpl());
  sl.registerLazySingleton<InternetConnectionRepository>(() => InternetConnectionRepositoryImpl());
  sl.registerLazySingleton<TTSRepository>(() => TTSRepositoryImpl());
  sl.registerLazySingleton<RouteRepository>(() => RouteRepositoryImpl());
  sl.registerLazySingleton<ImageCacheRepository>(() => ImageCacheRepositoryImpl(const PointEntity(x: 128, y: 128)));
  sl.registerLazySingleton<NavigationRepository>(() => NavigationRepositoryImpl(sl.get<ImageCacheRepository>()));
  sl.registerLazySingleton<TourRepository>(() => TourRepositoryImpl(openApi));
  sl.registerLazySingleton<FriendshipRepository>(() => FriendshipRepositoryImpl(
        openApi,
      ));
  sl.registerLazySingleton<AlertRepository>(() => AlertRepositoryImpl(openApi));
  sl.registerLazySingleton<PendingAlertsRepository>(() => PendingAlertsRepositoryImpl());
  sl.registerLazySingleton<RecorderRepository>(() => RecorderRepositoryImpl());
  sl.registerLazySingleton<PositionPredictionRepository>(() => PositionPredictionRepositoryImpl(openApi));

  sl.registerLazySingleton<MapWidgetBuilder>(() => MapWidgetBuilderImpl());

  // Usecases
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
  sl.registerLazySingleton<DeviceUseCase>(() => DeviceUseCase(sl.get<InternetConnectionRepository>()));
  sl.registerLazySingleton<RoutingUseCase>(() => RoutingUseCase(sl.get<RouteRepository>()));
  sl.registerLazySingleton<NavigationUseCase>(
      () => NavigationUseCase(sl.get<NavigationRepository>(), sl.get<TTSRepository>()));
  sl.registerLazySingleton<TourUseCase>(() => TourUseCase(sl.get<TourRepository>()));
  sl.registerLazySingleton<FriendshipUseCase>(() => FriendshipUseCase(sl.get<FriendshipRepository>()));
  sl.registerLazySingleton<AlertUseCase>(() => AlertUseCase(sl.get<AlertRepository>()));
  sl.registerLazySingleton<PendingAlertsUseCase>(() => PendingAlertsUseCase(sl.get<PendingAlertsRepository>()));
  sl.registerLazySingleton<RecorderUseCase>(
      () => RecorderUseCase(sl.get<RecorderRepository>(), sl.get<PermissionRepository>()));
  sl.registerLazySingleton<PositionPredictionUseCase>(
      () => PositionPredictionUseCase(sl.get<PositionPredictionRepository>()));

  // Blocs
  sl.registerLazySingleton<AuthenticationViewBloc>(() => AuthenticationViewBloc());
  sl.registerLazySingleton<ContentStoreBloc>(() => ContentStoreBloc());
  sl.registerLazySingleton<RegistrationViewBloc>(() => RegistrationViewBloc());
  sl.registerLazySingleton<MapViewBloc>(() => MapViewBloc(AssetBundleEntityImpl()));
  sl.registerLazySingleton<LocationBloc>(() => LocationBloc());
  sl.registerLazySingleton<AppBloc>(() => AppBloc());
  sl.registerLazySingleton<UserProfileBloc>(() => UserProfileBloc());
  sl.registerLazySingleton<AuthSessionBloc>(() => AuthSessionBloc());
  sl.registerLazySingleton<EditUserProfileViewBloc>(() => EditUserProfileViewBloc());
  sl.registerLazySingleton<SearchUsersBloc>(() => SearchUsersBloc());
  sl.registerLazySingleton<SearchMenuBloc>(() => SearchMenuBloc());
  sl.registerLazySingleton<DeviceInfoBloc>(() => DeviceInfoBloc(sl.get<DeviceUseCase>()));
  sl.registerLazySingleton<RoutingViewBloc>(() => RoutingViewBloc());
  sl.registerLazySingleton<NavigationViewBloc>(() => NavigationViewBloc());
  sl.registerLazySingleton<HomeViewBloc>(() => HomeViewBloc());
  sl.registerLazySingleton<NavigationInstructionPanelBloc>(() => NavigationInstructionPanelBloc());
  sl.registerLazySingleton<TourRecordingBloc>(
      () => TourRecordingBloc(sl.get<RecorderUseCase>(), sl.get<TourUseCase>()));
  sl.registerLazySingleton<FriendshipsViewBloc>(() => FriendshipsViewBloc(sl.get<FriendshipUseCase>()));
  sl.registerLazySingleton<AlertBloc>(
      () => AlertBloc(sl.get<AlertUseCase>(), sl.get<DeviceInfoBloc>(), sl.get<PendingAlertsUseCase>()));
  sl.registerLazySingleton<MapStylesPanelBloc>(() => MapStylesPanelBloc());
  sl.registerLazySingleton<SettingsViewBloc>(() => SettingsViewBloc());
  sl.registerLazySingleton<PositionPredictionBloc>(() => PositionPredictionBloc(sl.get<PositionPredictionUseCase>()));
  sl.registerLazySingleton<RouteProfilePanelBloc>((() => RouteProfilePanelBloc()));

  sl.registerLazySingleton<MapPlatform>(() => MapPlatformImpl());

  //Factories
  sl.registerLazySingleton<PathFactory>(() => PathFactoryImpl());
  sl.registerLazySingleton<TourFactory>(() => TourFactoryImpl());
  sl.registerLazySingleton<LandmarkFactory>(() => LandmarkFactoryImpl());

  await sl.get<SettingsUseCase>().init();
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
