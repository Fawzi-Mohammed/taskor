import 'package:equatable/equatable.dart';

class SignupData extends Equatable {
  const SignupData({
    required this.name,
    this.username,
    required this.email,
    required this.password,
    required this.hourlyRate,
  });

  final String name;
  final String? username;
  final String email;
  final String password;
  final double hourlyRate;

  String get safeUsername {
    return name.trim();
  }

  @override
  List<Object?> get props => [name, username, email, password, hourlyRate];
}
