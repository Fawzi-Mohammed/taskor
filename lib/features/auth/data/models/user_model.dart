import 'package:taskor/features/auth/domain/entities/user.dart';

class UserModel {
  const UserModel({
    required this.name,
    required this.username,
    required this.email,
    this.hourlyRate,
  });

  final String name;
  final String username;
  final String email;
  final double? hourlyRate;

  User toEntity() {
    return User(
      name: name,
      username: username,
      email: email,
      hourlyRate: hourlyRate,
    );
  }

  factory UserModel.fromJson(
    Map<String, dynamic> json, {
    required String fallbackIdentifier,
  }) {
    final userMap = _extractUserMap(json);

    final identifier = fallbackIdentifier.trim();
    final inferredUsername = _inferUsername(identifier);

    return UserModel(
      name: (userMap['name'] as String?)?.trim().isNotEmpty == true
          ? (userMap['name'] as String).trim()
          : inferredUsername,
      username: (userMap['username'] as String?)?.trim().isNotEmpty == true
          ? (userMap['username'] as String).trim()
          : inferredUsername,
      email: (userMap['email'] as String?)?.trim().isNotEmpty == true
          ? (userMap['email'] as String).trim()
          : (identifier.contains('@') ? identifier : ''),
      hourlyRate: _toDouble(userMap['hourlyRate']),
    );
  }

  static Map<String, dynamic> _extractUserMap(Map<String, dynamic> json) {
    final user = json['user'];
    if (user is Map<String, dynamic>) {
      return user;
    }

    final data = json['data'];
    if (data is Map<String, dynamic>) {
      final nestedUser = data['user'];
      if (nestedUser is Map<String, dynamic>) {
        return nestedUser;
      }
      return data;
    }

    return json;
  }

  static String _inferUsername(String identifier) {
    if (identifier.contains('@')) {
      return identifier.split('@').first;
    }
    return identifier;
  }

  static double? _toDouble(Object? value) {
    if (value is num) {
      return value.toDouble();
    }

    if (value is String) {
      return double.tryParse(value.trim());
    }

    return null;
  }
}
