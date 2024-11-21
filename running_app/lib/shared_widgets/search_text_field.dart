import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final Widget? prefix;
  final Widget? suffix;

  final String? placeholderText;

  final FocusNode? focusNode;

  const SearchTextField({
    super.key,
    this.onTap,
    this.onChanged,
    this.prefix,
    this.suffix,
    this.placeholderText,
    this.controller,
    this.focusNode,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  bool _firstTime = true;

  @override
  void initState() {
    widget.controller?.addListener(() {
      if (_firstTime && widget.controller!.text.isNotEmpty) {
        _firstTime = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: PlatformTextField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.center,
        material: (context, platform) =>
            getMaterialSearchBarData(context, platform, prefix: widget.prefix, suffix: widget.suffix),
        cupertino: (context, platform) =>
            getCupertinoSearchBarData(context, platform, prefix: widget.prefix, suffix: widget.suffix),
        onTap: widget.onTap,
        style: Theme.of(context).textTheme.bodyMedium,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        onChanged: (text) {
          if (widget.controller != null) {
            widget.controller!.text = text;
            widget.onChanged!(text);

            return;
          }

          if (widget.onChanged != null) {
            widget.onChanged!(text);
          }
        },
        cursorColor: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }

  CupertinoTextFieldData getCupertinoSearchBarData(BuildContext context, PlatformTarget target,
      {Widget? prefix, Widget? suffix}) {
    return CupertinoTextFieldData(
      prefix: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: prefix ??
            Icon(
              FontAwesomeIcons.magnifyingGlass,
              size: 20,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
      suffix: suffix,
      textAlignVertical: TextAlignVertical.center,
      placeholderStyle:
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      placeholder: widget.placeholderText ?? AppLocalizations.of(context)!.whereTo,
      padding: EdgeInsets.zero,
      cursorColor: Theme.of(context).colorScheme.primary,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
    );
  }

  MaterialTextFieldData getMaterialSearchBarData(BuildContext context, PlatformTarget target,
      {Widget? prefix, Widget? suffix}) {
    return MaterialTextFieldData(
      textAlignVertical: TextAlignVertical.center,
      cursorColor: Theme.of(context).colorScheme.primary,
      decoration: InputDecoration(
        prefixIcon: prefix ??
            Icon(
              FontAwesomeIcons.magnifyingGlass,
              size: 20,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
        suffixIcon: suffix,
        suffix: const SizedBox(height: 30),
        hintText: widget.placeholderText ?? AppLocalizations.of(context)!.whereTo,
        hintStyle:
            Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
    );
  }
}
