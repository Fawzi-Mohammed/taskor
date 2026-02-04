part of 'forget_password_block_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
  @override
  List<Object?> get props => [];
}

class RequestResetSubmitted extends ForgotPasswordEvent {
  const RequestResetSubmitted(this.email);
  final String email;

  @override
  List<Object?> get props => [email];
}

class VerifyCodeSubmitted extends ForgotPasswordEvent {
  const VerifyCodeSubmitted(this.code);
  final String code;

  @override
  List<Object?> get props => [code];
}

class ResetPasswordSubmitted extends ForgotPasswordEvent {
  const ResetPasswordSubmitted(this.newPassword);
  final String newPassword;

  @override
  List<Object?> get props => [newPassword];
}

class ForgotPasswordResetFlow extends ForgotPasswordEvent {
  const ForgotPasswordResetFlow();
}
