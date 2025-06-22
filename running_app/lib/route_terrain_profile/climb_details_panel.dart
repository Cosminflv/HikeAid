import 'package:shared/domain/sections/climb_section_entity.dart';
import '../utils/unit_converters.dart';
import 'named_card.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClimbDetailsPanel extends StatelessWidget {
  final List<ClimbSectionEntity> steepSections;
  final void Function(int, int) onTap;
  final bool isInteractive;

  const ClimbDetailsPanel({super.key, required this.steepSections, required this.onTap, required this.isInteractive});

  @override
  Widget build(BuildContext context) {
    return NamedCard(
      title: "Climb details",
      isInteractive: isInteractive,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //const Divider(),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            child: Table(
              border: TableBorder(
                  verticalInside: BorderSide(
                      width: 0.5, color: Theme.of(context).colorScheme.outlineVariant, style: BorderStyle.solid),
                  horizontalInside: BorderSide(
                      width: 0.5, color: Theme.of(context).colorScheme.outlineVariant, style: BorderStyle.solid)),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
              },
              children: [
                _getRowSpacer(),
                TableRow(children: [
                  Center(
                      child: Icon(CupertinoIcons.arrow_up_right_square_fill,
                          size: 25, color: Theme.of(context).colorScheme.onSurface)),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Start/End Points\nStart/End Elevation",
                          maxLines: 2,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Length",
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Avg Grade",
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ]),
                for (final steepSection in steepSections) ...[
                  _getRowSpacer(),
                  TableRow(
                    decoration: BoxDecoration(
                      color: _getColor(steepSection),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Center(
                          child: Builder(
                            builder: (context) {
                              switch (steepSection.type) {
                                case DClimbGrade.grade1:
                                  return Text("1", style: Theme.of(context).textTheme.bodySmall);
                                case DClimbGrade.grade2:
                                  return Text("2", style: Theme.of(context).textTheme.bodySmall);
                                case DClimbGrade.grade3:
                                  return Text("3", style: Theme.of(context).textTheme.bodySmall);
                                case DClimbGrade.grade4:
                                  return Text("4", style: Theme.of(context).textTheme.bodySmall);
                                case DClimbGrade.gradeHC:
                                  return Text("HC", style: Theme.of(context).textTheme.bodySmall);
                              }
                            },
                          ),
                        ),
                      ),
                      TableRowInkWell(
                        onTap: () => onTap(steepSection.startDistance, steepSection.endDistance),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "${convertDistance(steepSection.startDistance, getDistanceUnit(context))} / ${convertDistance(steepSection.endDistance, getDistanceUnit(context))}\n${convertDistance(steepSection.startElevation.floor(), getDistanceUnit(context))} / ${convertDistance(steepSection.endElevation.floor(), getDistanceUnit(context))}",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            convertDistance(steepSection.sectionLength, getDistanceUnit(context)),
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 2,
                          ),
                        ),
                      ),
                      Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            style: Theme.of(context).textTheme.bodySmall,
                            "${steepSection.averageGrade.toStringAsFixed(2)}%",
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          //const SizedBox(height: 10),
          if (steepSections.isEmpty)
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("Not avaliable", style: Theme.of(context).textTheme.bodySmall),
            ),
        ],
      ),
      onDetailsTap: () {},
    );
  }

  Color _getColor(ClimbSectionEntity section) {
    switch (section.type) {
      case DClimbGrade.gradeHC:
        return const Color.fromARGB(100, 255, 100, 40);
      case DClimbGrade.grade1:
        return const Color.fromARGB(100, 255, 140, 40);
      case DClimbGrade.grade2:
        return const Color.fromARGB(100, 255, 180, 40);
      case DClimbGrade.grade3:
        return const Color.fromARGB(100, 255, 220, 40);
      case DClimbGrade.grade4:
        return const Color.fromARGB(100, 255, 240, 40);
    }
  }

  TableRow _getRowSpacer() {
    return const TableRow(
      children: [
        SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 4,
        ),
      ],
    );
  }
}
