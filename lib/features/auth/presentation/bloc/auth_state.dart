import 'package:equatable/equatable.dart';

enum AuthAction {
  login,
  signUp,
  logout,
  forgotPassword,
  verifyResetCode,
  resetPassword,
}

enum AuthFailureType { server, offline, auth }

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => <Object?>[];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading(this.action);

  final AuthAction action;

  @override
  List<Object?> get props => <Object?>[action];
}

class AuthLoginSuccess extends AuthState {
  const AuthLoginSuccess();
}

class AuthSignUpSuccess extends AuthState {
  const AuthSignUpSuccess();
}

class AuthLogoutSuccess extends AuthState {
  const AuthLogoutSuccess();
}

class AuthForgotPasswordSuccess extends AuthState {
  const AuthForgotPasswordSuccess({
    required this.email,
    required this.verificationCode,
  });

  final String email;
  final String verificationCode;

  @override
  List<Object?> get props => <Object?>[email, verificationCode];
}

class AuthVerifyResetCodeSuccess extends AuthState {
  const AuthVerifyResetCodeSuccess({required this.email, required this.code});

  final String email;
  final String code;

  @override
  List<Object?> get props => <Object?>[email, code];
}

class AuthResetPasswordSuccess extends AuthState {
  const AuthResetPasswordSuccess();
}

class AuthError extends AuthState {
  const AuthError({
    required this.message,
    required this.action,
    required this.type,
  });

  final String message;
  final AuthAction action;
  final AuthFailureType type;

  @override
  List<Object?> get props => <Object?>[message, action, type];
}
