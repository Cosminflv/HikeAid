import 'package:flutter/material.dart';

class RecordInformationItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String measureUnit;
  final String label;
  final VoidCallback onTap;

  const RecordInformationItem({
    super.key,
    required this.icon,
    required this.value,
    required this.measureUnit,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 5),
            SizedBox(
              width: 20,
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: value,
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 35),
                        ),
                        TextSpan(
                          text: measureUnit,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SelectedRecordInformationItem extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final String value;
  final String measurementUnit;

  const SelectedRecordInformationItem(
      {super.key, required this.onTap, required this.label, required this.value, required this.measurementUnit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label),
            Text(
              value,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 100),
            ),
            Text(
              measurementUnit,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
