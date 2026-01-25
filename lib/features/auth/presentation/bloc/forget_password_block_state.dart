import 'package:equatable/equatable.dart';

enum ForgotStep { email, code, newPassword }

enum ForgotStatus { initial, loading, success, failure }

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.status = ForgotStatus.initial,
    this.step = ForgotStep.email,
    this.email = '',
    this.code = '',
    this.message,
  });

  final ForgotStatus status;
  final ForgotStep step;
  final String email;
  final String code;
  final Object? message;

  ForgotPasswordState copyWith({
    ForgotStatus? status,
    ForgotStep? step,
    String? email,
    String? code,
    Object? message,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      step: step ?? this.step,
      email: email ?? this.email,
      code: code ?? this.code,
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, step, email, code, message];
}
