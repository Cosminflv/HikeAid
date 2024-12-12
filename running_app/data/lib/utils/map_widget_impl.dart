import 'package:data/utils/map_widget_builder_impl.dart';
import 'package:domain/map_widget.dart';
import 'package:data/repositories_impl/extensions.dart';

import 'package:gem_kit/map.dart';

import 'package:flutter/src/widgets/framework.dart';

class MapWidgetImpl extends MapWidget {
  MapWidgetImpl({super.onMapCreated, super.initialCoordinates, super.zoomLevel, super.authorizationToken});

  @override
  Widget build(BuildContext context) {
    return GemMap(
      appAuthorization: authorizationToken ?? '',
      zoomLevel: zoomLevel,
      coordinates: initialCoordinates?.toGemCoordinates(),
      onMapCreated: (gemController) {
        if (super.onMapCreated == null) return;

        super.onMapCreated!(MapControllerImpl(gemController));
      },
    );
  }
}
