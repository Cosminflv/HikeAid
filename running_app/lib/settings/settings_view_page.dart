import 'package:core/di/app_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:running_app/config/routes.dart';
import 'package:running_app/position_prediction/position_prediction_events.dart';
import 'package:running_app/shared_widgets/custom_text_button.dart';

class SettingsViewPage extends StatelessWidget {
  const SettingsViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      iosContentBottomPadding: true,
      iosContentPadding: true,
      material: (context, platform) => MaterialScaffoldData(
        resizeToAvoidBottomInset: false,
      ),
      appBar: PlatformAppBar(
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          children: [
            _buildSection(
              context,
              title: 'Maps',
              buttonText: 'Download Maps',
              icon: Icons.map_rounded,
              onPressed: () => Navigator.pushNamed(context, RouteNames.contentStore),
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: 'Import GPX',
              buttonText: 'Import Path',
              icon: Icons.upload_file_rounded,
              onPressed: () {
                AppBlocs.positionPredictionBloc.add(ImportGPXDemoEvent('assets/gpx_files/demo.gpx'));
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String buttonText,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 12),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          CustomElevatedButton(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            textColor: Theme.of(context).colorScheme.onPrimaryContainer,
            text: buttonText,
            leading: Icon(
              icon,
              size: 24,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            alignment: MainAxisAlignment.center,
            onTap: onPressed,
          ),
        ],
      ),
    );
  }
}
