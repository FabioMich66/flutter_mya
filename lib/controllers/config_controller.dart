import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/config_model.dart';
import '../services/storage_service.dart';
import '../services/api_service.dart';

final configProvider =
    AsyncNotifierProvider<ConfigController, ConfigModel?>(() => ConfigController());

class ConfigController extends AsyncNotifier<ConfigModel?> {
  final storage = StorageService();
  final api = ApiService();

  @override
  Future<ConfigModel?> build() async {
    // Carica la configurazione all'avvio
    final cfg = await storage.loadConfig();
    return cfg;
  }

  Future<bool> saveAndLogin(ConfigModel config) async {
    state = const AsyncLoading();

    final token = await api.login(config);

    if (token == null) {
      state = AsyncError("Credenziali errate", StackTrace.current);
      return false;
    }

    await storage.saveConfig(config);

    // Aggiorna lo stato con la nuova configurazione
    state = AsyncData(config);
    return true;
  }
}
