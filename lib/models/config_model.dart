class ConfigModel {
  final String uri;
  final String user;
  final String password;
  final String? token;

  ConfigModel({
    required this.uri,
    required this.user,
    required this.password,
    this.token,
  });

  ConfigModel copyWith({
    String? uri,
    String? user,
    String? password,
    String? token,
  }) {
    return ConfigModel(
      uri: uri ?? this.uri,
      user: user ?? this.user,
      password: password ?? this.password,
      token: token ?? this.token,
    );
    }
}
