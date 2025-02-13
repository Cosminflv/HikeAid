import 'package:core/di/app_blocs.dart';
import 'package:domain/entities/alert_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/alerts/alert_bloc.dart';
import 'package:running_app/alerts/alert_events.dart';
import 'package:running_app/alerts/alert_state.dart';
import 'package:running_app/utils/unit_converters.dart';

class AlertPanelInformationSection extends StatelessWidget {
  final AlertEntity alert;
  final Future<int> confirmationsNumber;
  const AlertPanelInformationSection({
    super.key,
    required this.alert,
    required this.confirmationsNumber,
  });

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
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                FutureBuilder<int>(
                  future: confirmationsNumber,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading confirmations...");
                    } else if (snapshot.hasError) {
                      return const Text("Error loading confirmations");
                    } else {
                      return BlocBuilder<AlertBloc, AlertState>(
                          buildWhen: (previous, current) =>
                              previous.hasConfirmed == false && current.hasConfirmed == true,
                          builder: (context, alertState) {
                            int count = snapshot.data!;
                            if (alertState.hasConfirmed) count += 1;
                            AppBlocs.alertBloc.add(ResetHasConfirmedEvent());
                            return Text(
                              snapshot.data! == 0
                                  ? "No one has confirmed this alert yet"
                                  : "Confirmed by $count people",
                              style: Theme.of(context).textTheme.bodySmall,
                            );
                          });
                    }
                  },
                ),
                Text(alert.description,
                    overflow: TextOverflow.ellipsis, maxLines: 2, style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
