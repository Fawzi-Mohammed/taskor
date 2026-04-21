class LoginResponseModel {
  const LoginResponseModel({
    required this.token,
    required this.responseBody,
    this.watchCost,
  });

  final String token;
  final Map<String, dynamic> responseBody;
  final double? watchCost;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final token = _extractToken(json);
    return LoginResponseModel(
      token: token,
      responseBody: json,
      watchCost: _extractWatchCost(json),
    );
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

  static double? _extractWatchCost(Map<String, dynamic> json) {
    final data = json['data'];
    final nestedMap = data is Map<String, dynamic> ? data : null;

    final candidates = <Object?>[
      json['WatchCost'],
      json['watchCost'],
      json['hourlyRate'],
      nestedMap?['WatchCost'],
      nestedMap?['watchCost'],
      nestedMap?['hourlyRate'],
    ];

    for (final candidate in candidates) {
      if (candidate is num) {
        return candidate.toDouble();
      }

      if (candidate is String) {
        final parsed = double.tryParse(candidate.trim());
        if (parsed != null) {
          return parsed;
        }
      }
    }

    return null;
  }
}
