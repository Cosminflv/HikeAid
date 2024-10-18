import 'package:flutter/material.dart';

class ProfileItemPicker<T> extends StatelessWidget {
  final String title;
  final String value;
  final Function(BuildContext) onTap;

  const ProfileItemPicker({
    Key? key,
    required this.title,
    required this.value,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Container(
        color: Theme.of(context).highlightColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
        ),
      ),
    );
  }
}
