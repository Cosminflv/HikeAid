import 'package:domain/entities/alert_entity.dart';
import 'package:flutter/material.dart';
import 'package:running_app/utils/unit_converters.dart';

class AlertPanelInformationSection extends StatelessWidget {
  const AlertPanelInformationSection({
    super.key,
    required this.alert,
  });

  final AlertEntity alert;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "Posted by ${alert.authorName} • ${alert.createdAt.toErgonomicString()}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  alert.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
