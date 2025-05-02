import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared/domain/tour_entity.dart';

class TourCard extends StatelessWidget {
  final TourEntity tour;

  const TourCard({
    super.key,
    required this.tour,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Handle tour item tap
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with tap-to-view functionality
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: GestureDetector(
                onTap: () => _showFullImage(context, tour.previewImageUrl),
                child: Image.network(
                  tour.previewImageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tour.name,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    DateFormat.yMMMd().format(tour.date),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _MetricItem(
                        icon: Icons.timeline,
                        label: tour.distance >= 1000
                            ? '${NumberFormat('#.##').format(tour.distance / 1000)} km'
                            : '${tour.distance} m',
                      ),
                      _MetricItem(
                        icon: Icons.access_time,
                        label: _formatDuration(Duration(seconds: tour.duration)),
                      ),
                      _MetricItem(
                        icon: Icons.arrow_upward,
                        label: '${tour.totalUp} m',
                      ),
                      _MetricItem(
                        icon: Icons.arrow_downward,
                        label: '${tour.totalDown} m',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            InteractiveViewer(
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              top: MediaQuery.of(ctx).padding.top + 10,
              right: 5,
              child: Material(
                color: Colors.black45,
                shape: const CircleBorder(),
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper widget for metrics
class _MetricItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetricItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Theme.of(context).primaryColor),
        const SizedBox(width: 4),
        Text(
          label,
        ),
      ],
    );
  }
}

// Duration formatting helper
String _formatDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);
  if (hours > 0) {
    return '${hours}h ${minutes}m';
  }

  if (minutes > 0) {
    return '${minutes}m ${seconds}s';
  }
  return '${seconds}s';
}
