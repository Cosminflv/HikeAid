import 'package:core/di/injection_container.dart';
import 'package:domain/entities/local_map_style_entity.dart';
import 'package:domain/use_cases/content_store_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'map_styles_panel_events.dart';
import 'map_styles_panel_state.dart';

class MapStylesPanelBloc extends Bloc<MapStylesPanelEvent, MapStylesPanelState> {
  final _contentStoreUseCase = sl.get<ContentStoreUseCase>();

  MapStylesPanelBloc() : super(const MapStylesPanelState()) {
    on<ToggleMapStylesVisibilityEvent>(_handleToggleVisibility);
    on<InitLocalMapStylesEvent>(_handleInitLocalMapStyles);
    on<SelectMapStyleEvent>(_handleSelectMapStyle);
  }

  _handleToggleVisibility(ToggleMapStylesVisibilityEvent event, Emitter<MapStylesPanelState> emit) =>
      emit(state.copyWith(isVisible: !state.isVisible));

  _handleInitLocalMapStyles(InitLocalMapStylesEvent event, Emitter<MapStylesPanelState> emit) async {
    final styles = await _contentStoreUseCase.getAvailableLocalStyles();

    emit(state.copyWith(styles: styles));

    final selectedIndex = event.mapStylePath != null ? getIndexOfStyleByPath(event.mapStylePath!, styles) : null;

    emit(state.copyWith(styles: styles, selectedMapStyle: selectedIndex != null ? styles[selectedIndex] : null));
  }

  _handleSelectMapStyle(SelectMapStyleEvent event, Emitter<MapStylesPanelState> emit) {
    emit(state.copyWith(selectedMapStyle: event.style));
  }

  int getIndexOfStyleByPath(String stylePath, List<LocalMapStyleEntity> styles) => stylePath.trim().isNotEmpty
      ? styles.indexWhere((element) => element.path.split('/').last == stylePath.split('/').last)
      : 0;
}
