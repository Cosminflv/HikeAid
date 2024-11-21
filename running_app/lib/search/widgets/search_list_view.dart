import 'package:domain/entities/landmark_with_distance_entity.dart';

import 'package:flutter/material.dart';
import 'package:running_app/config/theme.dart';
import 'package:running_app/search/widgets/search_list_item.dart';
import 'package:running_app/search/widgets/search_padding.dart';

class SearchListView extends StatelessWidget {
  final List<LandmarkWithDistanceEntity> items;
  final Function(LandmarkWithDistanceEntity) onItemTap;
  const SearchListView({super.key, required this.items, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getAppbarColor(context),
      child: SearchPadding(
        child: Scrollbar(
          interactive: true,
          child: ListView(
            padding: EdgeInsets.zero,
            children: List.generate(
                items.length,
                (index) => LandmarkListItem(
                      landmark: items[index],
                      onTap: () => onItemTap(items[index]),
                    )),
          ),
        ),
      ),
    );
  }
}
