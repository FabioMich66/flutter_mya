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
    return AppModel(
      id: json['id'].toString(),     // sicurezza: sempre stringa
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      iconDataUrl: json['icon'],     // può essere null
    );
  }
}
