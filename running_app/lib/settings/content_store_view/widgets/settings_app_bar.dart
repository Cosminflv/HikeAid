import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

PlatformAppBar getSettingsAppBar(BuildContext context,
        {required String previousPageTitle,
        required String title,
        Color? backgroundColor,
        bool automaticallyImplyLeading = true,
        List<Widget>? trailingActions}) =>
    PlatformAppBar(
      material: (context, platform) => MaterialAppBarData(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        centerTitle: true,
      ),
      cupertino: (context, platform) => CupertinoNavigationBarData(
          padding: const EdgeInsetsDirectional.only(top: 10),
          previousPageTitle: previousPageTitle,
          backgroundColor: backgroundColor,
          border: const Border.fromBorderSide(BorderSide.none)),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor,
      trailingActions: trailingActions,
    );
