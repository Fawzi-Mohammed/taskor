class ForgotPasswordResponseModel {
  const ForgotPasswordResponseModel({
    required this.message,
    required this.verificationCode,
  });

  final String message;
  final String verificationCode;

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    final code = _extractCode(json);
    final message = _extractMessage(json);

    return ForgotPasswordResponseModel(
      message: message,
      verificationCode: code,
    );
  }

  static String _extractCode(Map<String, dynamic> json) {
    final data = json['data'];

    final candidates = <Object?>[
      json['code'],
      json['resetCode'],
      json['verificationCode'],
      data is Map<String, dynamic> ? data['code'] : null,
      data is Map<String, dynamic> ? data['resetCode'] : null,
      data is Map<String, dynamic> ? data['verificationCode'] : null,
    ];

    for (final candidate in candidates) {
      if (candidate is String && candidate.trim().isNotEmpty) {
        return candidate.trim();
      }
      if (candidate is num) {
        return candidate.toString();
      }
    }

    // Training backend returns a fixed code (1234).
    return '1234';
  }

  static String _extractMessage(Map<String, dynamic> json) {
    final data = json['data'];

    final candidates = <Object?>[
      json['message'],
      json['msg'],
      data is Map<String, dynamic> ? data['message'] : null,
      data is Map<String, dynamic> ? data['msg'] : null,
    ];

    for (final candidate in candidates) {
      if (candidate is String && candidate.trim().isNotEmpty) {
        return candidate.trim();
      }
    }

    return 'Verification code sent';
  }
}
