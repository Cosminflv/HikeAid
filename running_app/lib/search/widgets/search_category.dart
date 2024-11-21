import 'dart:typed_data';

import 'package:easy_sticky_header/easy_sticky_header.dart';
import 'package:flutter/material.dart';

import '../../config/theme.dart';
import 'search_padding.dart';

class SearchCategoryHeader extends StatelessWidget {
  final String title;
  final int index;

  const SearchCategoryHeader({super.key, required this.title, required this.index});

  @override
  Widget build(BuildContext context) {
    return StickyContainerWidget(
        index: index,
        child: SearchPadding(
          child: Container(
            color: getAppbarColor(context),
            height: 50,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ));
  }
}

class SearchCategoryItem extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Uint8List? image;
  final VoidCallback onTap;
  final Widget? trail;

  const SearchCategoryItem({super.key, required this.title, this.icon, this.image, required this.onTap, this.trail});

  @override
  Widget build(BuildContext context) {
    return SearchPadding(
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Container(
            color: getAppbarColor(context),
            height: 40,
            child: Row(
              children: [
                if (icon == null && image == null) const SizedBox(width: 20),
                if (icon != null)
                  SizedBox(width: 20, child: Icon(icon, size: 20, color: Theme.of(context).colorScheme.onSurface)),
                if (image != null) SizedBox(width: 20, child: Image.memory(image!, width: 20, height: 20)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (trail != null) trail!
              ],
            ),
          ),
        ),
      ),
    );
  }
}
