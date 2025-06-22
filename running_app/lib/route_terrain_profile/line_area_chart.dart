import 'dart:ui';

import 'package:running_app/route_terrain_profile/widgets/chart_cursor.dart';
import 'package:running_app/route_terrain_profile/widgets/ruler_widget.dart';
import 'package:running_app/utils/extensions.dart';
import 'package:shared/domain/sections/steep_section_entity.dart';
import 'package:domain/settings/general_settings_entity.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/unit_converters.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'widgets/teardrop_widget.dart';

class LineAreaChartController {
  Function(double)? setCurrentHighlight;
  Function(double, double)? changeViewport;
}

class LineAreaChart extends StatefulWidget {
  final void Function(double leftX, double rightX)? onViewPortChanged;
  final void Function(double x)? onSelect;
  final LineAreaChartController controller;

  late final double maxY;
  late final double minY;
  late final double maxX;
  late final double minX;

  static const double leftLabelBarWidth = 40;
  static const double bottomLabelBarHeight = 20;
  static const double tooptipWidth = 15;

  late final List<FlSpot> spots;
  final List<(List<FlSpot>, Color)> highlightedIntervals = [];
  final List<(double, double, Color)> highlightedColoredIntervals = [];
  final List<SteepSectionEntity> steepSections;

  final Color legendLabelColor;
  final Color? indicatorColor;
  final bool isInteractive;
  final bool withXAxis;
  final bool withYAxis;
  final bool withTopIcons;

  LineAreaChart({
    super.key,
    required this.controller,
    required List<(double, double)> points,
    required this.steepSections,
    this.onSelect,
    this.onViewPortChanged,
    this.legendLabelColor = Colors.black,
    this.indicatorColor,
    this.isInteractive = true,
    this.withXAxis = true,
    this.withYAxis = true,
    this.withTopIcons = true,
  }) {
    spots = points.map((e) => FlSpot(e.$1, e.$2)).toList();

    if (spots.isEmpty) {
      maxY = 0;
      minY = 0;
      maxX = 0;
      minX = 0;
    } else {
      final auxMaxY = spots.map((e) => e.y).reduce(max);
      final auxMinY = spots.map((e) => e.y).reduce(min);

      final deltaY = auxMaxY - auxMinY;

      maxY = auxMaxY + deltaY * 0.5;
      minY = auxMinY - deltaY * 0.18;

      maxX = spots.map((e) => e.x).reduce(max);
      minX = spots.map((e) => e.x).reduce(min);
    }
  }

  void setCurrentHighlight(double value) {
    state._setCurrentHighlight(value);
  }

  // ignore: library_private_types_in_public_api
  late final _LineAreaChartState state;

  @override
  // ignore: no_logic_in_create_state
  State<LineAreaChart> createState() {
    state = _LineAreaChartState();
    return state;
  }
}

class _LineAreaChartState extends State<LineAreaChart> with WidgetsBindingObserver {
  late double _currentLeftX;
  late double _currentRightX;
  double get _currentSectionLength => _currentRightX - _currentLeftX;
  double get _currentMiddleX => (_currentLeftX + _currentRightX) * 0.5;

  double? _currentHighlightX;

  int _timestampLastTwoFingersGesture = 0;
  int _timestampLastScaleGesture = 0;
  int _timestampLastViewportUpdatedCallback = 0;
  double _scaleOriginXMovingAverage = 0;

  Timer? _timerUntilOnViewportUpdate;

  _ViewportController viewportController = _ViewportController();
  _TooltipController tooltipController = _TooltipController();
  _TitleBarController titleBarController = _TitleBarController();

  double _minViewPortY = 0.0;
  double _maxViewPortY = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Durations.medium1);
      tooltipController.triggerRebuild();
    });
    resetMarginsAndHighlight();

    _updateViewportMinMax();
  }

  @override
  void didUpdateWidget(covariant LineAreaChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    resetMarginsAndHighlight();
  }

  void resetMarginsAndHighlight() {
    _currentLeftX = widget.minX;
    _currentRightX = widget.maxX;

    widget.controller.setCurrentHighlight = _setCurrentHighlight;
    widget.controller.changeViewport = _updatePresentedDomainLimits;

    viewportController.changeViewport(_currentLeftX, _currentRightX);
    titleBarController.horizontalAxisViewportChanged(_currentLeftX, _currentRightX);
    titleBarController.verticalAxisViewportChanged(widget.minY, widget.maxY);
    if (!widget.isInteractive) return;

    _setCurrentHighlight(_getXAtWidthPercentage(0.5), ignoreRestrictions: true);
  }

  void _setCurrentHighlight(double value, {bool ignoreRestrictions = false}) {
    if (!ignoreRestrictions) {
      if (widget.isInteractive &&
          (value - (_currentHighlightX ?? double.infinity)).abs() < _currentSectionLength * 0.01) {
        return;
      }
    }
    if (!mounted) return;

    _currentHighlightX = value;
    tooltipController.setHighlight(value);
    widget.onSelect?.call(value);
  }

  void _updatePresentedDomainLimits(double newMinX, double newMaxX) {
    final highlightXPercentage =
        _currentHighlightX != null ? (_currentHighlightX! - _currentLeftX) / (_currentRightX - _currentLeftX) : null;

    _currentLeftX = newMinX;
    _currentRightX = newMaxX;

    if (highlightXPercentage != null) {
      _setCurrentHighlight(_getXAtWidthPercentage(highlightXPercentage), ignoreRestrictions: true);
    }

    viewportController.changeViewport(_currentLeftX, _currentRightX);
    titleBarController.horizontalAxisViewportChanged(_currentLeftX, _currentRightX);
    tooltipController.triggerRebuild();

    _updateViewportMinMax();

    if (widget.onViewPortChanged == null) return;

    _timerUntilOnViewportUpdate?.cancel();

    if (DateTime.now().microsecondsSinceEpoch - _timestampLastViewportUpdatedCallback < 100) {
      _timerUntilOnViewportUpdate = Timer(const Duration(milliseconds: 50), () {
        widget.onViewPortChanged!(_currentLeftX, _currentRightX);
        //_timestampLastViewportUpdatedCallback = DateTime.now().millisecondsSinceEpoch;
      });
    } else {
      widget.onViewPortChanged!(_currentLeftX, _currentRightX);
      _timestampLastViewportUpdatedCallback = DateTime.now().millisecondsSinceEpoch;
    }

    setState(() {});
  }

  void _updateViewportMinMax() {
    FlSpot leftOutsideViewport = widget.spots.first;
    FlSpot rightOutsideViewport = widget.spots.last;

    List<FlSpot> spotsInViewPort = [];
    var spotIterationStatus = _SpotIterationStatus.leftOutsideViewport;
    for (final spot in widget.spots) {
      // Determine status
      if (spotIterationStatus == _SpotIterationStatus.leftOutsideViewport) {
        if (spot.x > _currentRightX) {
          spotIterationStatus = _SpotIterationStatus.rightOutsideViewport;
        } else if (spot.x > _currentLeftX) {
          spotIterationStatus = _SpotIterationStatus.inViewport;
        }
      } else if (spotIterationStatus == _SpotIterationStatus.inViewport) {
        if (spot.x > _currentRightX) {
          spotIterationStatus = _SpotIterationStatus.rightOutsideViewport;
        }
      }

      if (spotIterationStatus == _SpotIterationStatus.leftOutsideViewport) {
        leftOutsideViewport = spot;
      } else if (spotIterationStatus == _SpotIterationStatus.rightOutsideViewport) {
        rightOutsideViewport = spot;
        break;
      } else {
        spotsInViewPort.add(spot);
      }
    }

    final afterLeftOutsideViewport = spotsInViewPort.isEmpty ? rightOutsideViewport : spotsInViewPort.first;
    final beforeRightOutsideViewport = spotsInViewPort.isEmpty ? leftOutsideViewport : spotsInViewPort.last;

    final leftViewportSpot = FlSpot(
      _currentLeftX,
      lerpDouble(leftOutsideViewport.y, afterLeftOutsideViewport.y,
          (_currentLeftX - leftOutsideViewport.x) / (afterLeftOutsideViewport.x - leftOutsideViewport.x))!,
    );

    final rightViewportSpot = FlSpot(
      _currentRightX,
      lerpDouble(rightOutsideViewport.y, beforeRightOutsideViewport.y,
          (_currentRightX - rightOutsideViewport.x) / (beforeRightOutsideViewport.x - rightOutsideViewport.x))!,
    );

    spotsInViewPort = [leftViewportSpot, ...spotsInViewPort, rightViewportSpot];

    _minViewPortY = spotsInViewPort.fold(double.infinity, (a, b) => min(a, b.y));
    _maxViewPortY = spotsInViewPort.fold(double.negativeInfinity, (a, b) => max(a, b.y));
  }

  void _moveMiddleTowardsX(double x) {
    final leftXWhenXInMiddle = x - _currentSectionLength * 0.5;
    final rightXWhenXInMiddle = x + _currentSectionLength * 0.5;

    const lerpCoefficient = 0.01;

    final newLeftXInterpolated = _currentLeftX * (1 - lerpCoefficient) + leftXWhenXInMiddle * lerpCoefficient;
    final newRightXInterpolated = _currentRightX * (1 - lerpCoefficient) + rightXWhenXInMiddle * lerpCoefficient;

    _updatePresentedDomainLimits(newLeftXInterpolated, newRightXInterpolated);
  }

  double _getXAtWidthPercentage(double widthPercentage) {
    return _currentSectionLength * widthPercentage + _currentLeftX;
  }

  double _getTooltipXOffset(double widgetWidth) {
    return (_currentHighlightX! - _currentLeftX) / (_currentRightX - _currentLeftX) * widgetWidth -
        LineAreaChart.tooptipWidth / 2;
  }

  double _getLimitLineYOffset(double widgetHeight, double elevation) {
    return (elevation - widget.minY) / (widget.maxY - widget.minY) * widgetHeight;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      child: AspectRatio(
        aspectRatio: 2.3,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  if (widget.withYAxis)
                    _LeftTitleBar(
                      originalMinY: widget.minY,
                      originalMaxY: widget.maxY,
                      intervalsCount: 3,
                      bottomOffset: 0,
                      barWidth: LineAreaChart.leftLabelBarWidth,
                      textColor: widget.legendLabelColor,
                      controller: titleBarController,
                    ),
                  Expanded(
                    child: _ChartGestureDetector(
                      hasGestures: widget.isInteractive,
                      onDragWithOneFinger: (percentageOfChartWidth) {
                        if (DateTime.now().millisecondsSinceEpoch - _timestampLastTwoFingersGesture < 1000) return;

                        final highlightedDistance = _getXAtWidthPercentage(percentageOfChartWidth);
                        _setCurrentHighlight(highlightedDistance);
                      },
                      onDragWithTwoFingers: (deltaXOffset) {
                        deltaXOffset = deltaXOffset * _currentSectionLength * 0.0050;

                        final newMinX = _currentLeftX + deltaXOffset;
                        final newMaxX = _currentRightX + deltaXOffset;

                        if (newMinX < widget.minX) return;
                        if (newMaxX > widget.maxX) return;

                        _updatePresentedDomainLimits(newMinX, newMaxX);

                        _timestampLastTwoFingersGesture = DateTime.now().millisecondsSinceEpoch;
                      },
                      onScale: (percentageOfChartWidth, horizontalScale) {
                        // Move towards scale's point of origin
                        final startScaleXOrigin = _getXAtWidthPercentage(percentageOfChartWidth);

                        if (DateTime.now().millisecondsSinceEpoch - _timestampLastScaleGesture > 200) {
                          _scaleOriginXMovingAverage = startScaleXOrigin;
                        } else {
                          const newPositionWeight = 0.01;
                          _scaleOriginXMovingAverage = newPositionWeight * startScaleXOrigin +
                              (1 - newPositionWeight) * _scaleOriginXMovingAverage;
                        }
                        _moveMiddleTowardsX(_scaleOriginXMovingAverage);

                        // Scale
                        horizontalScale = 1 / horizontalScale;
                        const lerpCoefficient = 0.03;
                        horizontalScale = horizontalScale * lerpCoefficient + (1 - lerpCoefficient);

                        final newLength = _currentSectionLength * horizontalScale;
                        var newMinX = _currentMiddleX - newLength / 2;
                        var newMaxX = _currentMiddleX + newLength / 2;

                        if (newMinX < widget.minX) newMinX = widget.minX;
                        if (newMaxX > widget.maxX) newMaxX = widget.maxX;

                        double delta = newMaxX - newMinX;
                        if (delta < 10) return;

                        _updatePresentedDomainLimits(newMinX, newMaxX);

                        _timestampLastTwoFingersGesture = DateTime.now().millisecondsSinceEpoch;
                        _timestampLastScaleGesture = DateTime.now().millisecondsSinceEpoch;
                      },
                      child: AbsorbPointer(
                        child: Column(
                          children: [
                            if (widget.withXAxis)
                              _BottomTitleBar(
                                originalMinX: _currentLeftX,
                                originalMaxX: _currentRightX,
                                intervalsCount: 5,
                                textColor: widget.legendLabelColor,
                                barHeight: LineAreaChart.bottomLabelBarHeight,
                                leftOffset: LineAreaChart.leftLabelBarWidth,
                                controller: titleBarController,
                              ),
                            Expanded(
                              child: LayoutBuilder(builder: (context, widgetConstrains) {
                                return Stack(
                                  clipBehavior: Clip.none,
                                  fit: StackFit.expand,
                                  children: [
                                    _Chart(
                                      minY: widget.minY,
                                      maxY: widget.maxY,
                                      minX: widget.minX,
                                      maxX: widget.maxX,
                                      spots: widget.spots,
                                      steepSections: widget.steepSections,
                                      viewportController: viewportController,
                                      withXAxis: widget.withXAxis,
                                      withYAxis: widget.withYAxis,
                                    ),
                                    _ChartTooptip(
                                      xOffset: _getTooltipXOffset,
                                      yOffset: widgetConstrains.maxHeight + 45,
                                      indicatorColor: widget.indicatorColor ?? Theme.of(context).colorScheme.secondary,
                                      maxWidgetWidth: widgetConstrains.maxWidth,
                                      maxWidgetHeight: widgetConstrains.maxHeight,
                                      controller: tooltipController,
                                      textColor: widget.indicatorColor == null
                                          ? Theme.of(context).colorScheme.onSecondary
                                          : Colors.black,
                                    ),
                                    Positioned(
                                      bottom: _getLimitLineYOffset(widgetConstrains.maxHeight, _maxViewPortY) - 52,
                                      left: 0,
                                      child: _LimitLine(
                                        hasIcons: widget.withTopIcons,
                                        height: 80,
                                        width: widgetConstrains.maxWidth,
                                        label:
                                            convertDistance(_maxViewPortY.toInt(), DDistanceUnit.km, metersOnly: true),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: _getLimitLineYOffset(widgetConstrains.maxHeight, _minViewPortY) - 20,
                                      left: 0,
                                      child: _LimitLine(
                                        hasIcons: false,
                                        height: 20,
                                        width: widgetConstrains.maxWidth,
                                        label:
                                            convertDistance(_minViewPortY.toInt(), DDistanceUnit.km, metersOnly: true),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _SpotIterationStatus { inViewport, leftOutsideViewport, rightOutsideViewport }

class _LimitLine extends StatelessWidget {
  final bool hasIcons;
  final double height;
  final double width;
  final String label;

  const _LimitLine({
    required this.hasIcons,
    required this.label,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasIcons)
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TeardropIcon(
                  icon: FontAwesomeIcons.play,
                  isMirrored: false,
                ),
                TeardropIcon(
                  icon: FontAwesomeIcons.flagCheckered,
                  isMirrored: true,
                ),
              ],
            ),
          const DottedLine(dashColor: Colors.grey),
          Container(
            margin: const EdgeInsets.only(left: 5),
            height: 12,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          )
        ],
      ),
    );
  }
}

class _TooltipController {
  Function(double?) setHighlight = (_) {};
  Function() triggerRebuild = () {};
}

class _ChartTooptip extends StatefulWidget {
  const _ChartTooptip({
    required this.xOffset,
    required this.yOffset,
    required this.indicatorColor,
    required this.maxWidgetWidth,
    required this.maxWidgetHeight,
    required this.controller,
    required this.textColor,
  });

  final double Function(double) xOffset;
  final double yOffset;
  final double maxWidgetWidth;
  final double maxWidgetHeight;
  final _TooltipController controller;

  final Color indicatorColor;
  final Color textColor;

  @override
  State<_ChartTooptip> createState() => _ChartTooptipState();
}

class _ChartTooptipState extends State<_ChartTooptip> {
  double? highlight;

  @override
  void initState() {
    super.initState();

    _rebindController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _rebindController();
  }

  void _rebindController() {
    widget.controller.setHighlight = (spot) {
      if (!mounted) return;
      setState(() {
        highlight = spot;
      });
    };

    widget.controller.triggerRebuild = () {
      if (!mounted) return;
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    if (highlight == null) return Container();
    final offsetX = widget.xOffset(widget.maxWidgetWidth);
    final offsetY = widget.yOffset;

    if (offsetX < -LineAreaChart.tooptipWidth / 2 || offsetX > widget.maxWidgetWidth - LineAreaChart.tooptipWidth / 2) {
      return Container();
    }

    return Positioned(
      left: offsetX,
      bottom: 0,
      height: offsetY,
      width: LineAreaChart.tooptipWidth,
      child: const ChartCursor(),
    );
  }
}

class _ViewportController {
  Function(double, double) changeViewport = (a, b) {};
}

class _Chart extends StatefulWidget {
  const _Chart({
    required this.minY,
    required this.maxY,
    required this.minX,
    required this.maxX,
    required this.spots,
    required this.steepSections,
    required this.viewportController,
    required this.withXAxis,
    required this.withYAxis,
  });

  final double minY;
  final double maxY;
  final double minX;
  final double maxX;
  final List<FlSpot> spots;
  final List<SteepSectionEntity> steepSections;
  final _ViewportController viewportController;

  final bool withXAxis;
  final bool withYAxis;

  @override
  State<_Chart> createState() => _ChartState();
}

class _ChartState extends State<_Chart> {
  late double currentLeftX;
  late double currentRightX;
  final colors = <Color>[];
  final stops = <double>[];

  @override
  void initState() {
    super.initState();
    _updateColorsAndStops();
    currentLeftX = widget.minX;
    currentRightX = widget.maxX;
    _rebindController();
  }

  _updateColorsAndStops() {
    colors.clear();
    stops.clear();
    for (final interv in widget.steepSections) {
      final startPercentage = interv.startDistance / widget.spots.last.x;
      var endPercentage = interv.endDistance / widget.spots.last.x;
      endPercentage = lerpDouble(startPercentage, endPercentage, 0.95)!;

      stops.addAll([startPercentage, endPercentage]);
      colors.add(interv.type.getColorBasedOnSteepness());
      colors.add(interv.type.getColorBasedOnSteepness());
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _updateColorsAndStops();
    _rebindController();
  }

  void _rebindController() {
    widget.viewportController.changeViewport = (left, right) {
      setState(() {
        currentLeftX = left;
        currentRightX = right;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        titlesData: const FlTitlesData(
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        maxY: widget.maxY,
        minY: widget.minY,
        maxX: currentRightX,
        minX: currentLeftX,
        lineBarsData: [
          LineChartBarData(
            spots: widget.spots,
            color: colors.isEmpty ? Theme.of(context).colorScheme.primary : null,
            gradient: colors.isNotEmpty ? LinearGradient(colors: colors, stops: stops) : null,
            isCurved: false,
            barWidth: 4,
            curveSmoothness: 10,
            preventCurveOverShooting: true,
            dotData: const FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              show: true,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
        gridData: const FlGridData(
          show: false,
          drawVerticalLine: false,
          horizontalInterval: 1000,
          verticalInterval: 100,
        ),
        //Border
        borderData: FlBorderData(
          show: true,
          border: Border(
            top: const BorderSide(width: 0, color: Colors.transparent),
            right: const BorderSide(width: 0, color: Colors.transparent),
            bottom: const BorderSide(width: 0, color: Colors.transparent),
            left: widget.withYAxis
                ? const BorderSide(width: 1, color: Color(0xff37434d))
                : const BorderSide(width: 0, color: Colors.transparent),
          ),
        ),

        clipData: const FlClipData.all(),
      ),
    );
  }
}

class _TitleBarController {
  Function(double start, double end) verticalAxisViewportChanged = (_, __) {};
  Function(double start, double end) horizontalAxisViewportChanged = (_, __) {};
}

class _LeftTitleBar extends StatefulWidget {
  final double originalMinY;
  final double originalMaxY;
  final int intervalsCount;
  final double barWidth;
  final double bottomOffset;
  final _TitleBarController controller;

  final Color textColor;

  const _LeftTitleBar({
    required this.originalMinY,
    required this.originalMaxY,
    required this.intervalsCount,
    required this.barWidth,
    required this.bottomOffset,
    required this.textColor,
    required this.controller,
  });

  @override
  State<_LeftTitleBar> createState() => _LeftTitleBarState();
}

class _LeftTitleBarState extends State<_LeftTitleBar> {
  double minY = 0;
  double maxY = 0;

  @override
  void initState() {
    super.initState();

    minY = widget.originalMinY;
    maxY = widget.originalMaxY;

    _bindController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _bindController();
  }

  void _bindController() {
    widget.controller.verticalAxisViewportChanged = (mn, mx) {
      setState(() {
        minY = mn;
        maxY = mx;
      });
    };
  }

  double getValueAtInterval(int interval) {
    return minY + (maxY - minY) * (widget.intervalsCount - interval - 1) / (widget.intervalsCount - 1);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.barWidth,
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < widget.intervalsCount; i++)
                  Text(
                    convertDistance(getValueAtInterval(i).toInt(), getDistanceUnit(context),
                        withUnit: i == 0, metersOnly: true),
                    style: TextStyle(fontSize: 9, color: widget.textColor),
                    textAlign: TextAlign.right,
                  ),
              ],
            ),
          ),
          SizedBox(height: widget.bottomOffset),
        ],
      ),
    );
  }
}

class _BottomTitleBar extends StatefulWidget {
  final double originalMinX;
  final double originalMaxX;
  final int intervalsCount;
  final double barHeight;
  final double leftOffset;
  final _TitleBarController controller;

  final Color textColor;

  const _BottomTitleBar({
    required this.originalMinX,
    required this.originalMaxX,
    required this.intervalsCount,
    required this.barHeight,
    required this.leftOffset,
    required this.textColor,
    required this.controller,
  });

  @override
  State<_BottomTitleBar> createState() => _BottomTitleBarState();
}

class _BottomTitleBarState extends State<_BottomTitleBar> {
  double minX = 0;
  double maxX = 0;

  @override
  void initState() {
    super.initState();

    minX = widget.originalMinX;
    maxX = widget.originalMaxX;

    _bindController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _bindController();
  }

  void _bindController() {
    widget.controller.horizontalAxisViewportChanged = (mn, mx) {
      setState(() {
        minX = mn;
        maxX = mx;
      });
    };
  }

  double getValueAtInterval(int interval) {
    return minX + (maxX - minX) * interval / (widget.intervalsCount - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        ChartAxisRuler(
          color: Theme.of(context).colorScheme.onSurface,
          labels: List.generate(
            widget.intervalsCount,
            (index) => getValueAtInterval(index).toInt() == 0
                ? "Start"
                : convertDistance(getValueAtInterval(index).toInt(), getDistanceUnit(context), withUnit: true),
          ),
        )
      ],
    );
  }
}

class _ChartGestureDetector extends StatelessWidget {
  final void Function(double percentageOfChartWidth) onDragWithOneFinger;
  final void Function(double deltaXOffset) onDragWithTwoFingers;
  final void Function(double percentageOfChartWidthStart, double horizontalScale) onScale;
  final Widget child;
  final bool hasGestures;

  const _ChartGestureDetector({
    required this.onDragWithOneFinger,
    required this.onDragWithTwoFingers,
    required this.onScale,
    required this.hasGestures,
    required this.child,
  });

  double getPercentageOfChartWidthFromXOffset(double xOffset, double widgetWidth) {
    return xOffset / widgetWidth;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return GestureDetector(
        onScaleUpdate: (details) {
          if (!hasGestures) return;
          // Higher than 1 -> gestures with high vertical range are more likely to be recognized
          // Closer to 1 -> gestures with high vertical range are less likely to be recognized
          const scaleV = 5;

          // Higher than 1 -> the gesture has higher chance of being registered as DRAG TWO FINGERS
          // Closer to 1 -> the gesture has higher chance of being registred as SCALE
          const scaleH = 1.30;

          // Ignore extreme vertical gestures
          if (details.verticalScale < 1 / scaleV || details.verticalScale > scaleV) return;

          if (details.scale < 1 / scaleH || details.scale > scaleH) {
            // SCALE
            final horizontalScale = details.horizontalScale;
            final startLocalFocalPointX = details.localFocalPoint.dx;
            final startPercentageX = getPercentageOfChartWidthFromXOffset(startLocalFocalPointX, constrains.maxWidth);

            onScale(startPercentageX, horizontalScale);
          } else if (details.pointerCount == 1) {
            // DRAG ONE FINGER
            final percentageOfWidgetX =
                getPercentageOfChartWidthFromXOffset(details.localFocalPoint.dx, constrains.maxWidth);
            if (percentageOfWidgetX < 0 || percentageOfWidgetX > 1) return;
            onDragWithOneFinger(percentageOfWidgetX);
          } else if (details.pointerCount == 2) {
            // DRAG TWO FINGERS
            onDragWithTwoFingers(-details.focalPointDelta.dx);
          }
        },
        child: child,
      );
    });
  }
}
