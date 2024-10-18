import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textController;
  final Function(String value) onChanged;
  final String hintText;

  const CustomTextField({
    super.key,
    required this.textController,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyMedium,
      onChanged: (value) => onChanged(value),
      controller: textController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15.0),
        hintText: hintText,
      ),
    );
  }
}
