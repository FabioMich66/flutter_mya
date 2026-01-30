class AppModel {
  final String id;
  String name;
  String url;
  String? iconDataUrl; // base64 data URL

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

  factory AppModel.fromJson(Map<String, dynamic> json) => AppModel(
        id: json['id'],
        name: json['name'],
        url: json['url'],
        iconDataUrl: json['icon'],
      );
}
