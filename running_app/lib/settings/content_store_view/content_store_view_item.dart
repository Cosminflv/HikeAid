import 'package:core/di/app_blocs.dart';
import 'package:domain/entities/content_store_item_entity.dart';
import 'package:domain/use_cases/content_store_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:running_app/config/theme.dart';
import 'package:running_app/utils/sizes.dart';
import 'package:running_app/utils/unit_converters.dart';

class ContentStoreViewItemController {
  Function(int) setProgress = (_) {};
  Function(DContentStoreItemStatus) setStatus = (_) {};
  Function(bool) setSelected = (_) {};
}

class ContentStoreViewItem extends StatefulWidget {
  final ContentStoreItemEntity item;
  final int index;
  final VoidCallback onTap;
  final VoidCallback onDeleteTap;

  final bool isSelectable;
  final ContentStoreSource source;

  final bool isFirst;
  final bool isLast;

  final ContentStoreViewItemController controller;

  const ContentStoreViewItem({
    super.key,
    required this.item,
    required this.index,
    this.isSelectable = true,
    required this.source,
    required this.onTap,
    required this.onDeleteTap,
    required this.controller,
    required this.isLast,
    required this.isFirst,
  });

  @override
  State<ContentStoreViewItem> createState() => _ContentStoreViewItemState();
}

class _ContentStoreViewItemState extends State<ContentStoreViewItem> {
  int _progress = 0;
  DContentStoreItemStatus _status = DContentStoreItemStatus.unavailable;
  bool _isSelected = false;

  @override
  void initState() {
    _progress = widget.item.downloadProgress;
    _status = widget.item.status;

    widget.controller.setProgress = _setProgress;
    widget.controller.setStatus = _setStatus;
    widget.controller.setSelected = _setSelected;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant ContentStoreViewItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    _progress = widget.item.downloadProgress;
    _status = widget.item.status;

    widget.controller.setProgress = _setProgress;
    widget.controller.setStatus = _setStatus;
    widget.controller.setSelected = _setSelected;
  }

  void _setProgress(int progress) {
    if (!mounted) return;
    setState(() {
      _progress = progress;
    });
  }

  void _setStatus(DContentStoreItemStatus status) {
    if (!mounted) return;
    setState(() {
      _status = status;
    });
  }

  void _setSelected(bool value) {
    if (!mounted) return;
    setState(() {
      _isSelected = value && widget.isSelectable;
    });
  }

  _onTap() async {
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    final previewWidth = 50.0;
    final imgSize = Sizes.countryFlagImageSize;

    return ClipRRect(
      borderRadius: _getItemBorderRadius(),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: _onTap,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: getThemedItemBackgroundColor(context)),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SizedBox(
                      width: previewWidth,
                      child: AspectRatio(
                        aspectRatio: imgSize.x / imgSize.y,
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).colorScheme.shadow,
                                spreadRadius: 1,
                                blurRadius: 3,
                              )
                            ],
                          ),
                          child: Material(
                            elevation: 4,
                            shape: const CircleBorder(side: BorderSide(color: Colors.black, width: 0.5)),
                            child: ClipOval(
                              child: Builder(builder: (context) {
                                final preview = AppBlocs.contentStore.getItemPreview(widget.index);
                                if (preview == null) {
                                  return const Icon(CupertinoIcons.photo);
                                }
                                return Image.memory(
                                  height: 128,
                                  width: 128,
                                  preview,
                                  fit: BoxFit.scaleDown,
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      widget.item.name,
                                      maxLines: 2,
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Text(
                                      convertBytes(widget.item.totalSize.toDouble()),
                                      style: Theme.of(context).textTheme.labelMedium,
                                    ),
                                  ],
                                ),
                              ),
                              if (_status == DContentStoreItemStatus.completed)
                                IconButton(
                                  onPressed: widget.onDeleteTap,
                                  icon: const Icon(
                                    CupertinoIcons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              if (_status == DContentStoreItemStatus.unavailable)
                                IconButton(
                                  onPressed: widget.onDeleteTap,
                                  icon: const Icon(
                                    CupertinoIcons.cloud_download,
                                    color: Colors.blue,
                                  ),
                                ),
                              if (_status == DContentStoreItemStatus.paused)
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    CupertinoIcons.play,
                                    color: Colors.green,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (_progress > 0 && _progress < 100 && widget.source == ContentStoreSource.remote && mounted)
                            LinearProgressIndicator(
                              color: Theme.of(context).colorScheme.primary,
                              backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(5),
                              value: _progress / 100,
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (!widget.isLast)
                Divider(
                  indent: previewWidth + 10,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 0,
                ),
            ],
          ),
        ),
      ),
    );
  }

  _getItemBorderRadius() {
    if (widget.isFirst && widget.isLast) {
      return BorderRadius.circular(20.0);
    }
    if (widget.isFirst) {
      return const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0));
    }
    if (widget.isLast) {
      return const BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0));
    }
    return BorderRadius.zero;
  }
}
