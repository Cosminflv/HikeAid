import 'package:core/di/app_blocs.dart';
import 'package:domain/entities/connectivity_status.dart';
import 'package:domain/entities/content_store_entity.dart';
import 'package:domain/entities/content_store_item_entity.dart';
import 'package:domain/repositories/content_store_repository.dart';
import 'package:domain/use_cases/content_store_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/internet_connection/device_info_bloc.dart';
import 'package:running_app/internet_connection/device_info_state.dart';
import 'package:running_app/settings/content_store_view/widgets/search_row.dart';

import 'content_store_bloc.dart';
import 'content_store_events.dart';
import 'content_store_state.dart';
import 'content_store_view_item.dart';

class ContentStoreViewPage extends StatefulWidget {
  final DContentStoreItemType type;
  const ContentStoreViewPage({super.key, required this.type});

  @override
  State<ContentStoreViewPage> createState() => ContentStoreViewPageState();
}

class ContentStoreViewPageState extends State<ContentStoreViewPage> {
  late final ContentStoreBloc bloc;
  final TextEditingController searchController = TextEditingController();
  bool isCardDismissed = false;

  @override
  void initState() {
    super.initState();
    bloc = AppBlocs.contentStore;
    bloc.add(UpdateContentStoreSourceEvent(type: widget.type, source: ContentStoreSource.local));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: AppBlocs.deviceInfo,
        ),
        BlocProvider.value(
          value: AppBlocs.contentStore,
        ),
      ],
      child: BlocConsumer<ContentStoreBloc, ContentStoreState>(
          bloc: bloc,
          listener: (context, state) => searchController.text = state.query,
          builder: (context, contentStoreState) {
            return Builder(builder: (context) {
              if (contentStoreState.updateModuleStatus == DMapsUpdateModuleStatus.updating ||
                  contentStoreState.updateModuleStatus == DMapsUpdateModuleStatus.waitingConnection) {
                return const Center(child: CircularProgressIndicator());
              }
              return PlatformScaffold(
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                iosContentBottomPadding: true,
                iosContentPadding: true,
                material: (context, platform) => MaterialScaffoldData(
                  resizeToAvoidBottomInset: false,
                ),
                appBar: PlatformAppBar(
                  title: const Text("Maps"),
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                  automaticallyImplyLeading: true,
                  leading: BackButton(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                bottomNavBar: PlatformNavBar(
                    height: 80,
                    currentIndex: contentStoreState.contentStoreSource.index,
                    itemChanged: (index) => bloc.add(
                        UpdateContentStoreSourceEvent(type: widget.type, source: ContentStoreSource.values[index])),
                    material: (context, platform) =>
                        _getMaterialNavBarData(context, platform, DContentStoreItemType.roadMap),
                    cupertino: (context, platform) => _getCupertinoNavBarData(context, platform),
                    items: const [
                      BottomNavigationBarItem(
                        label: 'Offline',
                        icon: SizedBox.square(
                          dimension: 40,
                          child: Padding(padding: EdgeInsets.all(5.0), child: Icon(Icons.download_for_offline)),
                        ),
                      ),
                      BottomNavigationBarItem(
                        label: 'Online',
                        icon: SizedBox.square(
                          dimension: 40,
                          child: Padding(padding: EdgeInsets.all(5.0), child: Icon(FontAwesomeIcons.networkWired)),
                        ),
                      )
                    ]),
                body: Stack(
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          widget.type != DContentStoreItemType.mapStyleHighRes &&
                                  widget.type != DContentStoreItemType.mapStyleLowRes
                              ? SearchRow(
                                  backgroundColor: Colors.grey,
                                  onChanged: (query) => bloc.add(UpdateFilterTextEvent(query: query)),
                                  onCancelTap: () {
                                    bloc.add(UpdateFilterTextEvent(query: ''));
                                    searchController.clear();
                                  },
                                  textEditingController: searchController,
                                  shouldShowCancel: bloc.state.query.isNotEmpty,
                                  placeholderText: _getHintText(widget.type, contentStoreState.currentMapsVersion),
                                  hasHighlight: false,
                                )
                              : Container(),
                          BlocBuilder<DeviceInfoBloc, DeviceInfoState>(
                            builder: (context, connectionState) {
                              return BlocBuilder<ContentStoreBloc, ContentStoreState>(
                                  builder: (context, contentStoreState) {
                                if (!connectionState.hasInternetConnection &&
                                    contentStoreState.contentStoreSource == ContentStoreSource.remote) {
                                  return Expanded(
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            CupertinoIcons.antenna_radiowaves_left_right,
                                            color: Colors.red,
                                            size: 40,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "No Internet",
                                            style: Theme.of(context).textTheme.displaySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                if (contentStoreState.status == DContentStoreItemsStatus.failed) {
                                  return Expanded(
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                            size: 40,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Loading failed",
                                            style: Theme.of(context).textTheme.displaySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                if (contentStoreState.status == DContentStoreItemsStatus.loading) {
                                  return Expanded(
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Theme.of(context).colorScheme.onPrimary,
                                      ),
                                    ),
                                  );
                                }

                                if (contentStoreState.items.isEmpty) {
                                  return Expanded(
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "No Downloaded Maps",
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                if (contentStoreState.items.isNotEmpty) {
                                  return Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 10),
                                      child: ContentStoreItemsList(
                                        items: contentStoreState.items,
                                        type: widget.type,
                                        source: contentStoreState.contentStoreSource,
                                        onDeleteTap: (index) => bloc.add(DeleteItemEvent(
                                            index: index, source: contentStoreState.contentStoreSource)),
                                        onItemTap: _onItemTap,
                                      ),
                                    ),
                                  );
                                }
                                return Container();
                              });
                            },
                          ),
                        ]),
                  ],
                ),
              );
            });
          }),
    );
  }

  void _onItemTap(index) {
    final contentStore = AppBlocs.contentStore;
    final contentStoreState = contentStore.state;
    final connectionBloc = AppBlocs.deviceInfo;
    final connectionState = connectionBloc.state;
    final item = contentStoreState.items[index].$1;

    const thresholdFileSizeDownloadMobileData = 104857600; // 100 MB

    // Download
    if (contentStoreState.contentStoreSource == ContentStoreSource.remote &&
        item.isDownloadingOrWaiting == false &&
        item.downloadProgress == 0) {
      // Show warning downloading large items when on mobile data
      if (connectionState.connectivityStatus == DConnectivityStatus.mobile &&
          item.totalSize > thresholdFileSizeDownloadMobileData) {
        _showCupertinoModalDataWarning(context).then((value) {
          if (value == false) return;
          bloc.add(ItemTapEvent(index: index));
        });
      } else {
        bloc.add(ItemTapEvent(index: index));
      }
      return;
    }

    bloc.add(ItemTapEvent(index: index));
  }

  Future<bool> _showCupertinoModalDataWarning(BuildContext context) async {
    return await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: const Text(
            'Are you sure you want to download this item using mobile data?',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                "Yes",
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                "No",
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          ],
        );
      },
    );
  }

  String _getHintText(DContentStoreItemType type, String? mapVersion) {
    switch (type) {
      case DContentStoreItemType.roadMap:
        if (mapVersion != null) return "Map Version: $mapVersion";
        return 'Search a map';
      case DContentStoreItemType.humanVoice:
        return 'Search';
      default:
        return "unknown";
    }
  }
}

class ContentStoreItemsList extends StatelessWidget {
  final List<(ContentStoreItemEntity, int, ContentStoreViewItemController)> items;
  final DContentStoreItemType type;
  final ContentStoreSource source;
  final void Function(int) onItemTap;
  final void Function(int) onDeleteTap;

  const ContentStoreItemsList({
    super.key,
    required this.items,
    required this.type,
    required this.source,
    required this.onItemTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index].$1;
        final itemIndex = items[index].$2;
        final controller = items[index].$3;
        return ContentStoreViewItem(
          item: item,
          index: itemIndex,
          controller: controller,
          isFirst: index == 0,
          isLast: index == items.length - 1,
          onTap: () => onItemTap(itemIndex),
          onDeleteTap: () => onDeleteTap(itemIndex),
          source: source,
        );
      },
    );
  }
}

MaterialNavBarData _getMaterialNavBarData(BuildContext context, PlatformTarget platform, DContentStoreItemType type) {
  return MaterialNavBarData(
    selectedItemColor: Theme.of(context).colorScheme.onPrimary,
    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
  );
}

CupertinoTabBarData _getCupertinoNavBarData(BuildContext context, PlatformTarget platform) {
  return CupertinoTabBarData(
    activeColor: Theme.of(context).colorScheme.primary,
    currentIndex: 0,
  );
}
