import '../utils/image_utils.dart';

class AppModel {
  final String id;
  final String name;
  final String url;
  final String? iconDataUrl; // base64 data URL

  AppModel({
    required this.id,
    required this.name,
    required this.url,
    this.iconDataUrl,
  });

  // MODEL → JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
        'icon': iconDataUrl,
      };

  // JSON → MODEL
  factory AppModel.fromJson(Map<String, dynamic> json) {
    String? iconDataUrl;

    final icon = json['icon'];

    if (icon != null) {
      // Caso 1: il backend manda già una stringa base64
      if (icon is String) {
        iconDataUrl = icon;
      }

      // Caso 2: il backend manda un oggetto tipo Buffer
      else if (icon is Map &&
          icon['data'] is Map &&
          icon['data']['data'] is List) {
        final bytes = List<int>.from(icon['data']['data']);
        iconDataUrl = ImageUtils.bytesToDataUrl(bytes);
      }
    }

    return AppModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      iconDataUrl: iconDataUrl,
    );
  }
}
