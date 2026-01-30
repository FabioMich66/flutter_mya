import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/context_menu_controller.dart';
import '../controllers/edit_controller.dart';
import '../controllers/drag_controller.dart';
import '../controllers/launcher_controller.dart';
import '../services/launcher_service.dart';
import '../models/app_model.dart';

class AppIcon extends ConsumerWidget {
  final AppModel app;
  final int index;
  final double zoom;

  const AppIcon({
    super.key,
    required this.app,
    required this.index,
    required this.zoom,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editMode = ref.watch(editProvider);

    final size = 80 * zoom;
    final radius = 16 * zoom;
    final fontSize = 11 * zoom;

    return Listener(
      onPointerDown: (event) {
        if (event.kind == PointerDeviceKind.mouse &&
            event.buttons == kSecondaryMouseButton &&
            editMode) {
          final pos = Offset(event.position.dx, event.position.dy);
          ref.read(contextMenuProvider.notifier).show(app.id, pos);
        }
      },
      child: GestureDetector(
        onLongPress: () {
          if (editMode) {
            final box = context.findRenderObject() as RenderBox;
            final pos = box.localToGlobal(Offset(size / 2, size));
            ref.read(contextMenuProvider.notifier).show(app.id, pos);
          } else {
            ref.read(editProvider.notifier).enter();
          }
        },
        onTap: () async {
          if (!editMode) {
            await LauncherService().openAsApp(app.url);
          }
        },
        onPanStart: editMode
            ? (details) {
                ref.read(dragProvider.notifier).start(app.id, index);
              }
            : null,
        onPanUpdate: editMode
            ? (details) {
                // TODO: migliorare hit test
              }
            : null,
        onPanEnd: editMode
            ? (details) {
                final dragState = ref.read(dragProvider.notifier).end();
                if (dragState.draggingId != null &&
                    dragState.fromIndex != null &&
                    dragState.overIndex != null) {
                  ref
                      .read(launcherProvider.notifier)
                      .reorderByIndices(dragState.fromIndex!, dragState.overIndex!);
                }
              }
            : null,
        child: Column(
          children: [
            SizedBox(
              width: size,
              height: size,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: app.iconDataUrl != null
                    ? Image.memory(
                        Uri.parse(app.iconDataUrl!).data!.contentAsBytes(),
                        fit: BoxFit.cover,
                      )
                    : Container(color: Colors.grey),
              ),
            ),
            SizedBox(height: 6 * zoom),
            Text(
              app.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
  }
}
