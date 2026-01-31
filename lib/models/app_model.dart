import 'dart:convert';

class AppModel {
  final String id;
  final String name;
  final String url;
  final String? iconDataUrl;

  AppModel({
    required this.id,
    required this.name,
    required this.url,
    this.iconDataUrl,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
        'icon': iconDataUrl,
      };

  factory AppModel.fromJson(Map<String, dynamic> json) {
    String? iconDataUrl;

    final icon = json['icon'];

    if (icon != null &&
        icon['data'] is String &&
        icon['mime'] is String) {

      final base64 = icon['data'];
      final mime = icon['mime'];

      iconDataUrl = "data:$mime;base64,$base64";
    }

    return AppModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
      iconDataUrl: iconDataUrl,
    );
  }
}
