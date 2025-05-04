import 'package:core/di/app_blocs.dart';
import 'package:domain/repositories/content_store_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter/material.dart';
import 'package:running_app/internet_connection/device_info_bloc.dart';
import 'package:running_app/internet_connection/device_info_state.dart';

import '../content_store_bloc.dart';
import '../content_store_events.dart';
import '../content_store_state.dart';

class MapUpdateView extends StatelessWidget {
  const MapUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = AppBlocs.contentStore;

    return PlatformScaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      material: (context, platform) => MaterialScaffoldData(resizeToAvoidBottomInset: false),
      appBar: PlatformAppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        cupertino: (context, platform) => CupertinoNavigationBarData(previousPageTitle: 'Back', border: const Border()),
        material: (context, platfrom) => MaterialAppBarData(
            systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        )),
        title: Text(
          "Maps",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          BlocBuilder<ContentStoreBloc, ContentStoreState>(
            builder: (context, state) {
              final progress = state.updateProgress ?? 0;

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 35.0, horizontal: 50),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: CircularProgressIndicator(
                            strokeWidth: 15,
                            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                            value: progress / 100,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("$progress%", style: Theme.of(context).textTheme.displayLarge),
                            BlocBuilder<DeviceInfoBloc, DeviceInfoState>(
                              builder: (context, connectivityState) {
                                return Text(
                                  enumStatusToString(state.updateModuleStatus, connectivityState.hasInternetConnection),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      bloc.add(CancelUpdateEvent());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 40),
                        child: Text(
                          "Cancel Update",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          BlocBuilder<ContentStoreBloc, ContentStoreState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Updating to version:", style: Theme.of(context).textTheme.titleLarge),
                  Text(state.availableMapsVersion, style: Theme.of(context).textTheme.titleLarge),
                ],
              );
            },
          )
        ],
      ),
    );
  }

  String enumStatusToString(DMapsUpdateModuleStatus status, bool isConnected) {
    if (!isConnected) return "Waiting connection";

    switch (status) {
      case DMapsUpdateModuleStatus.updating:
        return "Downloading";
      case DMapsUpdateModuleStatus.waitingConnection:
        return "Waiting connection";
      default:
        return "Unknown";
    }
  }
}
