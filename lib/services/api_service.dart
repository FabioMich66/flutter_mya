import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/app_model.dart';
import '../models/config_model.dart';

class ApiService {
  Future<String?> login(ConfigModel config) async {
    final url = Uri.parse('${config.uri}/auth/login');

    final res = await http.post(
      url,
      headers: { 'Content-Type': 'application/json' },
      body: jsonEncode({
        'email': config.user,
        'password': config.password,
      }),
    );

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      return json['token'];
    }

    return null;
  }

  Future<List<AppModel>> fetchApps(ConfigModel config, String token) async {
    final url = Uri.parse('${config.uri}/links');

    final res = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (res.statusCode != 200) return [];

    final json = jsonDecode(res.body);
    final list = json as List;

    return list
        .map((e) => AppModel(
              id: e['id'].toString(),
              name: e['name'],
              url: e['url'],
              iconDataUrl: e['icon'],
            ))
        .toList();
  }
}



