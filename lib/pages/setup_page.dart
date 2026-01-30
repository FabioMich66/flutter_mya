import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/config_controller.dart';
import '../models/config_model.dart';

class SetupPage extends ConsumerWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uriCtrl = TextEditingController();
    final userCtrl = TextEditingController();
    final passCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Configurazione')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: uriCtrl, decoration: const InputDecoration(labelText: 'URL')),
            TextField(controller: userCtrl, decoration: const InputDecoration(labelText: 'User')),
            TextField(controller: passCtrl, decoration: const InputDecoration(labelText: 'Password')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final cfg = ConfigModel(
                  uri: uriCtrl.text,
                  user: userCtrl.text,
                  password: passCtrl.text,
                );
                ref.read(configProvider.notifier).save(cfg);
              },
              child: const Text('Salva'),
            ),
          ],
        ),
      ),
    );
  }
}
