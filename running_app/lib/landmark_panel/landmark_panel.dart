import 'package:core/di/app_blocs.dart';
import 'package:domain/entities/landmark_entity.dart';
import 'package:flutter/material.dart';
import 'package:running_app/landmark_panel/widgets/landmark_panel_information_section.dart';
import 'package:running_app/landmark_panel/widgets/landmark_panel_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:running_app/routing/routing_view_events.dart';
import 'package:running_app/shared_widgets/dialogs/transport_mode_dialog.dart';

class LandmarkPanel extends StatelessWidget {
  final LandmarkEntity landmark;
  final VoidCallback onCloseTap;

  const LandmarkPanel({super.key, required this.landmark, required this.onCloseTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, boxShadow: [
        BoxShadow(
          blurRadius: 5,
          spreadRadius: 5,
          color: Theme.of(context).colorScheme.brightness == Brightness.light ? Colors.black26 : Colors.black26,
        )
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
              child: Column(
                children: [
                  LandmarkPanelInformationSection(
                    landmark: landmark,
                    onCloseTap: onCloseTap,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      LandmarkPanelButton(
                          text: AppLocalizations.of(context)!.setDestination,
                          onTap: () {
                            if (AppBlocs.routingBloc.state.transportMeans == null) {
                              showTransportModeChoice(context).then((hasConfirmed) {
                                if (hasConfirmed) {
                                  AppBlocs.routingBloc.add(BuildRouteEvent(
                                      departureCoordinates: AppBlocs.locationBloc.state.currentPosition!.coordinates,
                                      waypoints: [landmark]));
                                }
                              });
                            }
                          },
                          isFilled: false),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
