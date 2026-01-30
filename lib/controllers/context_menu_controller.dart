import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContextMenuState {
  final bool visible;
  final Offset position;
  final String? targetId;

  const ContextMenuState({
    required this.visible,
    required this.position,
    required this.targetId,
  });
}

final contextMenuProvider =
    NotifierProvider<ContextMenuController, ContextMenuState>(
        () => ContextMenuController());

class ContextMenuController extends Notifier<ContextMenuState> {
  @override
  ContextMenuState build() =>
      const ContextMenuState(visible: false, position: Offset.zero, targetId: null);

  void show(String id, Offset pos) {
    state = ContextMenuState(visible: true, position: pos, targetId: id);
  }

  void hide() {
    state = const ContextMenuState(visible: false, position: Offset.zero, targetId: null);
  }
}
