import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskor/features/auth/domain/usecases/request_password_reset_usecase.dart';
import 'package:taskor/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:taskor/features/auth/domain/usecases/verify_reset_code_usecase.dart';
import 'package:taskor/features/auth/presentation/bloc/forget_password_block_state.dart';

part 'forget_password_block_event.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({
    required RequestPasswordResetUseCase request,
    required VerifyResetCodeUseCase verify,
    required ResetPasswordUseCase reset,
  })  : _request = request,
        _verify = verify,
        _reset = reset,
        super(const ForgotPasswordState()) {
    on<RequestResetSubmitted>(_onRequestReset);
    on<VerifyCodeSubmitted>(_onVerifyCode);
    on<ResetPasswordSubmitted>(_onResetPassword);
    on<ForgotPasswordResetFlow>(_onResetFlow);
  }

  final RequestPasswordResetUseCase _request;
  final VerifyResetCodeUseCase _verify;
  final ResetPasswordUseCase _reset;

  Future<void> _onRequestReset(
    RequestResetSubmitted e,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(state.copyWith(status: ForgotStatus.loading, message: null));

    final res = await _request(email: e.email);
    res.fold(
      (f) => emit(state.copyWith(status: ForgotStatus.failure, message: f.message)),
      (_) => emit(
        state.copyWith(
          status: ForgotStatus.success,
          step: ForgotStep.code,
          email: e.email,
        ),
      ),
    );
  }

  Future<void> _onVerifyCode(
    VerifyCodeSubmitted e,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(state.copyWith(status: ForgotStatus.loading, message: null));

    final res = await _verify(email: state.email, code: e.code);
    res.fold(
      (f) => emit(state.copyWith(status: ForgotStatus.failure, message: f.message)),
      (_) => emit(
        state.copyWith(
          status: ForgotStatus.success,
          step: ForgotStep.newPassword,
          code: e.code,
        ),
      ),
    );
  }

  Future<void> _onResetPassword(
    ResetPasswordSubmitted e,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(state.copyWith(status: ForgotStatus.loading, message: null));

    final res = await _reset(
      email: state.email,
      code: state.code,
      newPassword: e.newPassword,
    );

    res.fold(
      (f) => emit(state.copyWith(status: ForgotStatus.failure, message: f.message)),
      (_) => emit(state.copyWith(status: ForgotStatus.success)),
    );
  }

  void _onResetFlow(
    ForgotPasswordResetFlow e,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(const ForgotPasswordState());
  }
}