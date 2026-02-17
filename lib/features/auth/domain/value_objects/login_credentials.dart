import 'package:equatable/equatable.dart';

class LoginCredentials extends Equatable {
  const LoginCredentials({
    required this.email,
    required this.password,
    required this.rememberMe,
  });

  final String email;
  final String password;
  final bool rememberMe;

  @override
  List<Object?> get props => [email, password, rememberMe];
}
