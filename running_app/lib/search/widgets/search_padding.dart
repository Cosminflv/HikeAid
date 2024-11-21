import 'package:flutter/widgets.dart';

class SearchPadding extends StatelessWidget {
  final Widget child;
  const SearchPadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: child);
  }
}
