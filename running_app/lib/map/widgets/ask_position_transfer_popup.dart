import 'package:core/di/app_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/position_prediction/position_prediction_bloc.dart';
import 'package:running_app/position_prediction/position_prediction_events.dart';
import 'package:running_app/position_prediction/position_prediction_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:running_app/utils/session_utils.dart';

/// A popup widget requesting user consent for real-time position transfer
class AskPositionTransferPopup extends StatelessWidget {
  const AskPositionTransferPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PositionPredictionBloc, PositionPredictionState>(
      listener: (context, state) {
        if (state.isPositionTransferEnabled == true) {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(true);
          }
        }
      },
      listenWhen: (previous, current) =>
          previous.isPositionTransferEnabled == false && current.isPositionTransferEnabled == true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(false),
            icon: Icon(
              FontAwesomeIcons.xmark,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          color: Theme.of(context).colorScheme.primaryContainer,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.consentPositionTitle,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.consentPositionSubtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 5,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.consentPositionSteps,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          AppLocalizations.of(context)!.consentPositionStepsDetail,
                          style: Theme.of(context).textTheme.bodyMedium!,
                        ),

                        //consentPositionStepsDetail
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => _handleButtonPress(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.consentPositionButton,
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleButtonPress(BuildContext context) {
    final positionBloc = AppBlocs.positionPredictionBloc;
    final positionState = positionBloc.state;
    if (!positionState.isPositionTransferEnabled) {
      positionBloc.add(ReisterPositionTransferEvent(getSession(context)!.user.id));
    }
  }
}
