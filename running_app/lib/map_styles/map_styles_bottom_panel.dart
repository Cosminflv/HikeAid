import 'package:core/di/app_blocs.dart';
import 'package:domain/entities/local_map_style_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:running_app/map_styles/map_styles_panel_events.dart';
import 'package:running_app/utils/extensions.dart';
import 'map_styles_panel_bloc.dart';
import 'map_styles_panel_state.dart';

class MapStylesBottomPanel extends StatefulWidget {
  const MapStylesBottomPanel({super.key});

  @override
  State<MapStylesBottomPanel> createState() => _MapStylesBottomPanelState();
}

class _MapStylesBottomPanelState extends State<MapStylesBottomPanel> {
  late ScrollController _hikingStylesScrollController;

  @override
  void initState() {
    _hikingStylesScrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _hikingStylesScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const aspectRatio = 3 / 4;
    const borderWidth = 2;
    final itemWidth = (screenWidth - 60 - borderWidth) / 2;
    final itemHeight = itemWidth * aspectRatio;
    final itemAspectRatio = itemHeight / itemWidth;

    const handleHeight = 5.0;
    const headerHeight = 30.0;
    const labelHeight = 40.0;
    final gridViewHeight = 2 * itemHeight + 10;
    final bottomPadding = MediaQuery.of(context).padding.bottom + 20;

    final panelHeight = handleHeight + headerHeight + 3 * labelHeight + gridViewHeight + bottomPadding + 20;

    return BlocProvider.value(
      value: AppBlocs.mapStylesBloc,
      child: BlocBuilder<MapStylesPanelBloc, MapStylesPanelState>(
        builder: (context, state) {
          return Material(
            type: MaterialType.transparency,
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              height: panelHeight,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: handleHeight,
                        width: MediaQuery.of(context).size.width / 4,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            borderRadius: BorderRadius.circular(10)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: headerHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.mapStyles,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox.square(
                          dimension: headerHeight,
                          child: CloseButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
                                  foregroundColor: Theme.of(context).colorScheme.surface,
                                  padding: EdgeInsets.zero),
                              onPressed: () => Navigator.of(context).pop()),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: labelHeight, child: Center(widthFactor: 1, child: Text("Hiking"))),
                  Builder(builder: (context) {
                    final non3DStyles = state.styles.where((e) => !e.hasElevation).toList();

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                        height: itemHeight + 10,
                        child: GridView.builder(
                          controller: _hikingStylesScrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: non3DStyles.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: itemAspectRatio,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemBuilder: (context, index) => SizedBox(
                            width: itemWidth,
                            child: MapStyleItem(
                              style: non3DStyles[index],
                              isSelected: non3DStyles[index] == state.selectedMapStyle,
                              onTap: () {
                                HapticFeedback.heavyImpact();
                                AppBlocs.mapStylesBloc.add(SelectMapStyleEvent(non3DStyles[index]));
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: labelHeight, child: Center(widthFactor: 1, child: Text('Hiking 3D'))),
                  Builder(builder: (context) {
                    final non3DStyles = state.styles.where((e) => e.hasElevation).toList();

                    return SizedBox(
                      height: itemHeight + 10,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: non3DStyles.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: itemAspectRatio,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemBuilder: (context, index) => MapStyleItem(
                          style: non3DStyles[index],
                          isSelected: non3DStyles[index] == state.selectedMapStyle,
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            AppBlocs.mapStylesBloc.add(SelectMapStyleEvent(non3DStyles[index]));
                          },
                        ),
                      ),
                    );
                  }),
                  SizedBox(
                    height: bottomPadding,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MapStyleItem extends StatelessWidget {
  final LocalMapStyleEntity style;
  final bool isSelected;
  final VoidCallback onTap;
  const MapStyleItem({super.key, required this.style, required this.isSelected, required this.onTap});

  final borderWidth = 3.0;
  final borderRadius = 10.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            width: borderWidth,
            color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primaryContainer,
          )),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius - borderWidth),
                child: Image.asset(
                  style.previewPath,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              width: 200,
              height: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                color:
                    isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primaryContainer,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    style.style.getLabel(context),
                    style: TextStyle(
                      color: isSelected
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
