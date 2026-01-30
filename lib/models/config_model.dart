class ConfigModel {
  final String uri;
  final String user;
  final String password;

  ConfigModel({
    required this.uri,
    required this.user,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'uri': uri,
        'user': user,
        'password': password,
      };

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
        uri: json['uri'],
        user: json['user'],
        password: json['password'],
      );
}
