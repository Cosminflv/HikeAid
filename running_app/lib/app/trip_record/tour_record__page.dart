import 'package:core/di/app_blocs.dart';
import 'package:domain/settings/general_settings_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/app/app_events.dart';
import 'package:running_app/app/app_state.dart';
import 'package:running_app/app/trip_record/widgets/record_information_item.dart';
import 'package:running_app/tour_recording/tour_recording_bloc.dart';
import 'package:running_app/tour_recording/tour_recording_state.dart';
import 'package:running_app/utils/unit_converters.dart';

class TourRecordPage extends StatelessWidget {
  const TourRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Theme.of(context).colorScheme.surface,
            height: MediaQuery.of(context).padding.top,
          ),
          const RecorderInformationPanel(
            withData: false,
          ),
          const Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Record"),
                  SizedBox(height: 20),
                  RecordButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecorderInformationPanel extends StatefulWidget {
  final bool withData;
  const RecorderInformationPanel({
    super.key,
    this.withData = true,
  });

  @override
  State<RecorderInformationPanel> createState() => _RecorderInformationPanelState();
}

class _RecorderInformationPanelState extends State<RecorderInformationPanel> with SingleTickerProviderStateMixin {
  int _selectedIndex = -1;

  late Animation animation;
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4 + 50 - MediaQuery.of(context).padding.top,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned.fill(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                mainAxisExtent: 100,
              ),
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: 4,
              itemBuilder: (context, index) => BlocBuilder<TourRecordingBloc, TourRecordingState>(
                key: ValueKey(index),
                buildWhen: (previous, current) => getRebuildCondition(previous, current, index),
                builder: (context, state) {
                  return RecordInformationItem(
                      icon: getIcon(index),
                      value: getValue(state, index),
                      measureUnit: getMeasurementUnit(index),
                      label: getLabel(index, context),
                      onTap: () => setState(() {
                            _selectedIndex = index;
                            animationController.forward();
                          }));
                },
              ),
            ),
          ),
          if (_selectedIndex != -1)
            Positioned.fill(
                child: BlocBuilder<TourRecordingBloc, TourRecordingState>(
              buildWhen: (previous, current) => getRebuildCondition(previous, current, _selectedIndex),
              builder: (context, state) {
                return AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return ScaleTransition(
                      scale: animation as Animation<double>,
                      alignment: getAlignment(_selectedIndex),
                      child: child,
                    );
                  },
                  child: SelectedRecordInformationItem(
                    onTap: () => animationController.reverse().then((value) {
                      setState(() {
                        _selectedIndex = -1;
                      });
                    }),
                    value: getValue(state, _selectedIndex),
                    label: getLabel(_selectedIndex, context),
                    measurementUnit: getMeasurementUnit(_selectedIndex),
                  ),
                );
              },
            ))
        ],
      ),
    );
  }

  String getValue(TourRecordingState state, int index) {
    if (!widget.withData) {
      return '--';
    }
    switch (index) {
      case 0:
        return state.currentSpeed != null
            ? convertSpeed(state.currentSpeed!, DSpeedUnit.kmPerHour).split(' ').first
            : '--';
      case 1:
        return state.averageSpeed != null
            ? convertSpeed(state.averageSpeed!, DSpeedUnit.kmPerHour).split(' ').first
            : '--';
      case 2:
        return state.timeInMotion != null ? convertTimeToCronometer(state.timeInMotion!) : '--';
      case 3:
        return state.distanceTraveled != null
            ? convertDistance(state.distanceTraveled!, DDistanceUnit.km, metersOnly: true).split(' ').first
            : '--';
      default:
        return '';
    }
  }

  Alignment getAlignment(int index) {
    switch (index) {
      case 0:
        return Alignment.topLeft;
      case 1:
        return Alignment.topRight;
      case 2:
        return Alignment.bottomLeft;
      case 3:
        return Alignment.bottomRight;
      default:
        return Alignment.center;
    }
  }

  String getLabel(int index, BuildContext context) {
    switch (index) {
      case 0:
        return AppLocalizations.of(context)!.currentSpeed;
      case 1:
        return AppLocalizations.of(context)!.averageSpeed;
      case 2:
        return "In motion";
      case 3:
        return "Traveled";
      default:
        return '';
    }
  }

  String getMeasurementUnit(int index) {
    switch (index) {
      case 0:
        return 'km/h';
      case 1:
        return 'km/h';
      case 2:
        return '';
      case 3:
        return 'm';
      default:
        return '';
    }
  }

  bool getRebuildCondition(TourRecordingState previous, TourRecordingState current, int index) {
    switch (index) {
      case 0:
        return previous.currentSpeed != current.currentSpeed;
      case 1:
        return previous.averageSpeed != current.averageSpeed;
      case 2:
        return previous.timeInMotion != current.timeInMotion;
      case 3:
        return previous.distanceTraveled != current.distanceTraveled;
      default:
        return false;
    }
  }

  IconData getIcon(int index) {
    switch (index) {
      case 0:
        return FontAwesomeIcons.gaugeHigh;
      case 1:
        return FontAwesomeIcons.gaugeHigh;
      case 2:
        return FontAwesomeIcons.stopwatch;
      case 3:
        return FontAwesomeIcons.arrowsLeftRight;
      default:
        return FontAwesomeIcons.arrowDown;
    }
  }
}

class RecordButton extends StatefulWidget {
  const RecordButton({super.key});

  @override
  RecordButtonState createState() => RecordButtonState();
}

class RecordButtonState extends State<RecordButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Future.delayed(Durations.medium1).then((value) {
          AppBlocs.appBloc.add(UpdateAppStatusEvent(AppStatus.recording));
        });
      },
      onTapDown: (_) {
        setState(() => _isPressed = true);
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: _isPressed ? 75 : 80, // Smaller width when pressed
        height: _isPressed ? 75 : 80, // Smaller height when pressed
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        child: const Center(
          child: Icon(
            Icons.fiber_manual_record,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }
}
