import 'package:equatable/equatable.dart';
import 'package:taskor/features/auth/domain/value_objects/login_credentials.dart';
import 'package:taskor/features/auth/domain/value_objects/signup_data.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends AuthEvent {
  const LoginSubmitted(this.credentials);
  final LoginCredentials credentials;

  @override
  List<Object?> get props => [credentials];
}

class SignupSubmitted extends AuthEvent {
  const SignupSubmitted(this.data);
  final SignupData data;

  @override
  List<Object?> get props => [data];
}

@override
class TryAgainPressed extends AuthEvent {
  const TryAgainPressed();
}
