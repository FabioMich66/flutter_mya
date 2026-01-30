import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/zoom_controller.dart';
import '../controllers/drag_controller.dart';
import '../controllers/edit_controller.dart';
import '../models/app_model.dart';
import 'app_icon.dart';

class AppGrid extends ConsumerWidget {
  final List<AppModel> apps;
  final List<String> order;

  const AppGrid({super.key, required this.apps, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final zoom = ref.watch(zoomProvider);
    final drag = ref.watch(dragProvider);
    final editMode = ref.watch(editProvider);

    final iconSize = 80 * zoom;
    final spacing = 20 * zoom;

    return GridView.builder(
      padding: EdgeInsets.all(spacing),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (MediaQuery.of(context).size.width / (iconSize + spacing)).floor().clamp(2, 10),
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: 0.8,
      ),
      itemCount: order.length,
      itemBuilder: (_, i) {
        final id = order[i];
        final app = apps.firstWhere((a) => a.id == id);

        final isPlaceholder =
            drag.draggingId != null && drag.overIndex == i && editMode;

        if (isPlaceholder) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16 * zoom),
              border: Border.all(color: Colors.blue.withOpacity(0.4), width: 2),
            ),
          );
        }

        return AppIcon(app: app, index: i, zoom: zoom);
      },
    );
  }
}


class _PlaceholderIcon extends StatelessWidget {
  const _PlaceholderIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withOpacity(0.4), width: 2),
      ),
    );
  }
}
