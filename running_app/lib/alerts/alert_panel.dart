import 'dart:typed_data';

import 'package:domain/entities/alert_entity.dart';
import 'package:flutter/material.dart';
import 'package:running_app/alerts/widgets/alert_panel_buttons_section.dart';
import 'package:running_app/alerts/widgets/alert_panel_information_section.dart';
import 'package:running_app/alerts/widgets/alert_panel_header.dart';

class AlertPanel extends StatefulWidget {
  final AlertEntity alert;
  final VoidCallback onCloseTap;
  final VoidCallback onValidAlertTap;
  final VoidCallback onInvalidAlertTap;
  const AlertPanel(
      {super.key,
      required this.alert,
      required this.onCloseTap,
      required this.onValidAlertTap,
      required this.onInvalidAlertTap});

  @override
  State<AlertPanel> createState() => _AlertPanelState();
}

class _AlertPanelState extends State<AlertPanel> {
  late Future<Uint8List?> alertImageFuture;
  late Future<int> alertConfirmationsNumber;

  @override
  void initState() {
    super.initState();
    alertImageFuture = widget.alert.loadImage();
    alertConfirmationsNumber = widget.alert.loadConfirmationsNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 5,
            color: Theme.of(context).colorScheme.brightness == Brightness.light ? Colors.black26 : Colors.black26,
          )
        ]),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LandmarkPanelHeader(alertImageFuture: alertImageFuture, onCloseTap: widget.onCloseTap),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Column(
                  children: [
                    AlertPanelInformationSection(alert: widget.alert, confirmationsNumber: alertConfirmationsNumber),
                    const SizedBox(height: 10),
                    AlertPanelButtonsSection(
                      onInvalidButtonTap: widget.onInvalidAlertTap,
                      onValidButtonTap: widget.onValidAlertTap,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
