import 'package:another_xlider/models/handler_animation.dart';
import 'package:flutter/material.dart';
import 'package:running_app/route_terrain_profile/widgets/chart_cursor.dart';
import 'package:shared/domain/sections/base_section_entity.dart';

import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';

import 'dart:async';

import '../utils/unit_converters.dart';

class SectionSlider<E> extends StatefulWidget {
  final List<BaseSectionEntity<E>> sections;
  final double width;
  final int distance;
  final Icon? Function(BaseSectionEntity) getArrowIcon;
  final void Function(BaseSectionEntity) onSelectionChanged;
  final String Function(BaseSectionEntity) getName;
  final Color Function(BaseSectionEntity) getColor;
  final bool isInteractive;

  const SectionSlider(
      {super.key,
      required this.sections,
      required this.width,
      required this.distance,
      required this.getArrowIcon,
      required this.onSelectionChanged,
      required this.getName,
      required this.getColor,
      this.isInteractive = true});

  @override
  State<SectionSlider> createState() => _RoadTypesSliderState<E>();
}

class _RoadTypesSliderState<E> extends State<SectionSlider> {
  late BaseSectionEntity _selectedRoadSection;
  late double _selectedValue;

  Timer? _debounce;

  @override
  void initState() {
    _selectedRoadSection = widget.sections.first;
    _selectedValue = 0.0;
    super.initState();
  }

  void _onSelectionChanged(double start, double dest) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 10), () {
      double total = 0;
      for (final section in widget.sections) {
        total += section.sectionLength;
        final diff = (total - dest).abs(); //Fix for floating point inaccuracy
        if (diff < 0.01) {
          widget.onSelectionChanged(section);
          return;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final handlerWidth = 14.0;

    return Column(children: <Widget>[
      SizedBox(
        height: widget.isInteractive ? 80 : 50,
        child: Stack(
          children: [
            Positioned(
              bottom: 10,
              left: handlerWidth / 2,
              child: SizedBox(
                width: widget.width,
                height: 30,
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(widget.sections.length, (index) {
                      final sectionWidth = (widget.width - handlerWidth) * widget.sections.elementAt(index).percent;
                      return Container(
                        width: sectionWidth,
                        color: widget.getColor(widget.sections[index]),
                      );
                    })),
              ),
            ),
            Positioned.fill(
              child: SizedBox(
                height: 100,
                child: FlutterSlider(
                  values: [_selectedValue],
                  max: widget.distance.toDouble(),
                  min: 0,
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    final interval = findIntervalLimits(lowerValue);
                    if (interval.isEmpty) return;
                    _onSelectionChanged(interval.first, interval.last);
                    _getSelectedRoadSection(lowerValue);
                  },
                  handlerWidth: handlerWidth,
                  handlerHeight: 70,
                  handlerAnimation: const FlutterSliderHandlerAnimation(duration: Duration.zero, scale: 1),
                  handler: FlutterSliderHandler(
                    decoration: const BoxDecoration(),
                    child: widget.isInteractive
                        ? const SizedBox(
                            height: 100,
                            width: 20,
                            child: ChartCursor(),
                          )
                        : const SizedBox.shrink(),
                  ),
                  tooltip: FlutterSliderTooltip(
                    disabled: !widget.isInteractive,
                    custom: (val) => const SizedBox(width: 1, height: 1),
                  ),
                  trackBar: const FlutterSliderTrackBar(
                    activeTrackBar: BoxDecoration(color: Colors.transparent),
                    inactiveTrackBar: BoxDecoration(color: Colors.transparent),
                    activeTrackBarHeight: 5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      if (!widget.isInteractive)
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            height: widget.sections.length * 30,
            child: Column(
                children: List.generate(widget.sections.length, (index) {
              return Container(
                padding: const EdgeInsets.only(left: 10, bottom: 5),
                child: Row(
                  children: [
                    Builder(builder: (context) {
                      if (widget.getArrowIcon(_selectedRoadSection) != null) {
                        return SizedBox(
                          width: 35,
                          height: 20,
                          child: widget.getArrowIcon(_selectedRoadSection),
                        );
                      }
                      return const SizedBox();
                    }),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.getColor(widget.sections[index]),
                      ),
                    ),
                    const SizedBox(width: 5),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: '${widget.getName(widget.sections[index])}:',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text:
                            ' ${convertDistance((widget.sections[index].percent * widget.distance).toInt(), getDistanceUnit(context))} (${(widget.sections[index].percent * 100).toStringAsFixed(1)}%)',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ]))
                  ],
                ),
              );
            })),
          ),
        ),
    ]);
  }

  _getSelectedRoadSection(double val) {
    final index = findPercentIndex(val);

    setState(() {
      _selectedRoadSection = widget.sections[index];
      _selectedValue = val;
    });
  }

  int findPercentIndex(double val) {
    List<double> accumulatedPercentages = [];
    double accumulatedPercentage = 0;
    for (final section in widget.sections) {
      accumulatedPercentage += section.percent;
      accumulatedPercentages.add(accumulatedPercentage);
    }

    for (var i = 0; i < accumulatedPercentages.length; i++) {
      if (val <= accumulatedPercentages[i] * widget.distance) {
        return i;
      }
    }

    return widget.sections.length - 1;
  }

  List<double> findIntervalLimits(double value) {
    double prevStart = 0;
    final dist = widget.distance;

    for (final s in widget.sections) {
      final sectionLength = s.percent * dist;
      if (value >= prevStart && value <= prevStart + sectionLength) {
        if (prevStart + sectionLength > dist) {
          return [prevStart, dist.toDouble()];
        }
        return [prevStart, prevStart + sectionLength];
      }
      prevStart += sectionLength;
    }

    return [];
  }
}
