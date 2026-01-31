import '../utils/image_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import 'config_controller.dart';

final launcherProvider =
    NotifierProvider<LauncherController, LauncherState>(() => LauncherController());

class LauncherState {
  final List<AppModel> apps;
  final List<String> order;

  LauncherState({required this.apps, required this.order});
}

class LauncherController extends Notifier<LauncherState> {
  final storage = StorageService();
  final api = ApiService();

  @override
  LauncherState build() {
    _load();
    return LauncherState(apps: [], order: []);
  }

  Future<void> _load() async {
    final cfg = ref.read(configProvider).value;
    if (cfg == null) return;

    final savedApps = await storage.loadApps();
    final savedOrder = await storage.loadOrder();

    List<AppModel> apps = savedApps ?? [];
    List<String> order = savedOrder ?? apps.map((a) => a.id).toList();

    state = LauncherState(apps: apps, order: order);
  }

  void renameApp(String id, String newName) {
    final apps = [...state.apps];
    final app = apps.firstWhere((a) => a.id == id);
    app.name = newName;
    storage.saveApps(apps);
    state = LauncherState(apps: apps, order: state.order);
  }

  void changeIcon(String id, List<int> bytes) {
    final apps = [...state.apps];
    final app = apps.firstWhere((a) => a.id == id);
    app.iconDataUrl = ImageUtils.bytesToDataUrl(bytes);
    storage.saveApps(apps);
    state = LauncherState(apps: apps, order: state.order);
  }

  void removeApp(String id) {
    final apps = state.apps.where((a) => a.id != id).toList();
    final order = state.order.where((o) => o != id).toList();
    storage.saveApps(apps);
    storage.saveOrder(order);
    state = LauncherState(apps: apps, order: order);
  }


  void reorderByIndices(int from, int to) {
    if (from == to) return;
    final newOrder = [...state.order];
    final id = newOrder.removeAt(from);
    newOrder.insert(to, id);
    storage.saveOrder(newOrder);
    state = LauncherState(apps: state.apps, order: newOrder);
  }


  Future<void> refreshFromServer() async {
    final cfg = ref.read(configProvider).config;
    if (cfg == null) return;

    final apps = await api.fetchApps(cfg);
    await storage.saveApps(apps);

    final order = apps.map((a) => a.id).toList();
    await storage.saveOrder(order);

    state = LauncherState(apps: apps, order: order);
  }

  void reorder(int oldIndex, int newIndex) {
    final newOrder = [...state.order];
    final id = newOrder.removeAt(oldIndex);
    newOrder.insert(newIndex, id);

    storage.saveOrder(newOrder);
    state = LauncherState(apps: state.apps, order: newOrder);
  }
}


