import 'package:equatable/equatable.dart';
import 'package:taskor/features/auth/domain/value_objects/login_credentials.dart';
import 'package:taskor/features/auth/domain/value_objects/signup_data.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class LoginEvent extends AuthEvent {
  const LoginEvent(this.credentials);

  final LoginCredentials credentials;

  @override
  List<Object?> get props => <Object?>[credentials];
}

class SignUpEvent extends AuthEvent {
  const SignUpEvent(this.data);

  final SignupData data;

  @override
  List<Object?> get props => <Object?>[data];
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}

class ForgotPasswordEvent extends AuthEvent {
  const ForgotPasswordEvent(this.email);

  final String email;

  @override
  List<Object?> get props => <Object?>[email];
}

class VerifyResetCodeEvent extends AuthEvent {
  const VerifyResetCodeEvent({required this.email, required this.code});

  final String email;
  final String code;

  @override
  List<Object?> get props => <Object?>[email, code];
}

class ResetPasswordEvent extends AuthEvent {
  const ResetPasswordEvent({
    required this.email,
    required this.code,
    required this.newPassword,
    required this.confirmPassword,
  });

  final String email;
  final String code;
  final String newPassword;
  final String confirmPassword;

  @override
  List<Object?> get props => <Object?>[
    email,
    code,
    newPassword,
    confirmPassword,
  ];
}
