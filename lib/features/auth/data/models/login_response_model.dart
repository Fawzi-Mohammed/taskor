class LoginResponseModel {
  const LoginResponseModel({required this.token, required this.responseBody});

  final String token;
  final Map<String, dynamic> responseBody;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final token = _extractToken(json);
    return LoginResponseModel(token: token, responseBody: json);
  }

  static String _extractToken(Map<String, dynamic> json) {
    final directCandidates = <Object?>[
      json['token'],
      json['accessToken'],
      json['jwt'],
      json['data'] is Map<String, dynamic>
          ? (json['data'] as Map<String, dynamic>)['token']
          : null,
      json['data'] is Map<String, dynamic>
          ? (json['data'] as Map<String, dynamic>)['accessToken']
          : null,
    ];

    for (final candidate in directCandidates) {
      if (candidate is String && candidate.trim().isNotEmpty) {
        return candidate.trim();
      }
    }

    throw const FormatException('Token not found in login response');
  }
}
