import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SearchRow extends StatefulWidget {
  const SearchRow({
    super.key,
    required this.onChanged,
    required this.onCancelTap,
    required this.textEditingController,
    required this.hasHighlight,
    required this.shouldShowCancel,
    this.placeholderText,
    this.backgroundColor,
    this.prefix,
  });

  final TextEditingController textEditingController;
  final Function(String) onChanged;
  final VoidCallback onCancelTap;
  final bool hasHighlight;
  final bool shouldShowCancel;
  final String? placeholderText;
  final Color? backgroundColor;
  final Widget? prefix;

  @override
  State<SearchRow> createState() => _SearchRowState();
}

class _SearchRowState extends State<SearchRow> {
  final FocusNode _searchFocusNode = FocusNode();

  late bool isCancelButtonVisible;
  @override
  void initState() {
    isCancelButtonVisible = false;
    _searchFocusNode.addListener(() => setState(() => isCancelButtonVisible = _searchFocusNode.hasFocus));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
      child: SafeArea(
        bottom: false,
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isMaterial(context))
              Expanded(
                child: SearchRowTextField(
                  focusNode: _searchFocusNode,
                  onChanged: widget.onChanged,
                  controller: widget.textEditingController,
                  hasHighlight: widget.hasHighlight,
                  placeholderText: widget.placeholderText,
                  prefix: widget.prefix,
                ),
              ),
            if (isCupertino(context))
              Expanded(
                  child: CupertinoTextField(
                padding: EdgeInsets.zero,
                placeholder: widget.placeholderText ?? 'Search',
                style: Theme.of(context).textTheme.bodyLarge,
                placeholderStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                cursorColor: Theme.of(context).colorScheme.primary,
                decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(30)),
                focusNode: _searchFocusNode,
                onChanged: widget.onChanged,
                onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
                controller: widget.textEditingController,
                prefix: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: widget.prefix ??
                      Icon(
                        CupertinoIcons.search,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              )),
            Visibility(
              visible: isCancelButtonVisible || widget.shouldShowCancel,
              child: PlatformTextButton(
                padding: const EdgeInsets.only(left: 10),
                onPressed: () => widget.onCancelTap(),
                child: Text('Cancel',
                    style:
                        Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchRowTextField extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool hasHighlight;
  final String? placeholderText;
  final Widget? prefix;

  const SearchRowTextField({
    super.key,
    this.focusNode,
    this.controller,
    this.onChanged,
    this.hasHighlight = false,
    this.placeholderText,
    this.prefix,
  });

  @override
  State<SearchRowTextField> createState() => _SearchRowTextFieldState();
}

class _SearchRowTextFieldState extends State<SearchRowTextField> {
  bool _firstTime = true;
  String _prevInput = '';

  @override
  void initState() {
    widget.controller?.addListener(() {
      if (_firstTime && widget.controller!.text.isNotEmpty) {
        _prevInput = widget.controller!.text;
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
        material: (context, platform) => getMaterialTextFieldData(
          context,
          platform,
          prefix: widget.prefix,
        ),
        style: Theme.of(context).textTheme.bodyMedium,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        onChanged: (text) {
          if (widget.hasHighlight && widget.controller != null) {
            final newText = _prevInput.length > text.length ? '' : text[text.length - 1];

            widget.controller!.text = newText;
            widget.onChanged!(newText);
            _prevInput = newText;

            return;
          }

          if (widget.onChanged != null) {
            widget.onChanged!(text);
            _prevInput = text;
          }
        },
        cursorColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  MaterialTextFieldData getMaterialTextFieldData(BuildContext context, PlatformTarget target, {Widget? prefix}) {
    return MaterialTextFieldData(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: widget.placeholderText ?? 'Search',
          hintStyle:
              Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
          prefixIcon: prefix ??
              Icon(
                CupertinoIcons.search,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        ));
  }
}
