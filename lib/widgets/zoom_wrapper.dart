import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/zoom_controller.dart';
import '../controllers/edit_controller.dart';

class ZoomWrapper extends ConsumerStatefulWidget {
  final Widget child;

  const ZoomWrapper({super.key, required this.child});

  @override
  ConsumerState<ZoomWrapper> createState() => _ZoomWrapperState();
}

class _ZoomWrapperState extends ConsumerState<ZoomWrapper> {
  double initialZoom = 1.0;

  @override
  Widget build(BuildContext context) {
    final editMode = ref.watch(editProvider);
    final zoomCtrl = ref.read(zoomProvider.notifier);

    return Listener(
      onPointerSignal: (signal) {
        if (!editMode) return;
        if (signal is PointerScrollEvent) {
          final direction = signal.scrollDelta.dy < 0 ? 1 : -1;
          final factor = 1 + direction * 0.1;
          final current = ref.read(zoomProvider);
          final newZoom = zoomCtrl.applyElastic(current * factor);
          zoomCtrl.applyZoom(newZoom);
        }
      },
      child: GestureDetector(
        onScaleStart: editMode
            ? (details) {
                initialZoom = ref.read(zoomProvider);
              }
            : null,
        onScaleUpdate: editMode
            ? (details) {
                final zoomCtrl = ref.read(zoomProvider.notifier);
                final newZoom = zoomCtrl.applyElastic(initialZoom * details.scale);
                zoomCtrl.applyZoom(newZoom);
              }
            : null,
        child: widget.child,
      ),
    );
  }
}
