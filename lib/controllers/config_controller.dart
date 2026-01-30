import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/config_model.dart';
import '../services/storage_service.dart';
import '../services/api_service.dart';

final configProvider =
    NotifierProvider<ConfigController, ConfigState>(() => ConfigController());

class ConfigState {
  final ConfigModel? config;
  final bool loading;
  final String? error;

  bool get isConfigured => config != null;

  ConfigState({this.config, this.loading = false, this.error});
}

class ConfigController extends Notifier<ConfigState> {
  final storage = StorageService();
  final api = ApiService();

  @override
  ConfigState build() {
    _load();
    return ConfigState();
  }

  Future<void> _load() async {
    final cfg = await storage.loadConfig();
    state = ConfigState(config: cfg);
  }

  Future<bool> saveAndLogin(ConfigModel config) async {
    state = ConfigState(config: null, loading: true);

    final token = await api.login(config);

    if (token == null) {
      state = ConfigState(error: 'Credenziali errate');
      return false;
    }

    await storage.saveConfig(config);
    state = ConfigState(config: config);
    return true;
  }
}
