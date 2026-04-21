import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskor/core/error/failures.dart';
import 'package:taskor/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:taskor/features/auth/domain/usecases/login_usecase.dart';
import 'package:taskor/features/auth/domain/usecases/logout_usecase.dart';
import 'package:taskor/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:taskor/features/auth/domain/usecases/signup_usecase.dart';
import 'package:taskor/features/auth/domain/usecases/verify_reset_code_usecase.dart';
import 'package:taskor/features/auth/presentation/bloc/auth_event.dart';
import 'package:taskor/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required LoginUseCase loginUseCase,
    required SignupUseCase signupUseCase,
    required LogoutUseCase logoutUseCase,
    required ForgotPasswordUseCase forgotPasswordUseCase,
    required VerifyResetCodeUseCase verifyResetCodeUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
  }) : _loginUseCase = loginUseCase,
       _signupUseCase = signupUseCase,
       _logoutUseCase = logoutUseCase,
       _forgotPasswordUseCase = forgotPasswordUseCase,
       _verifyResetCodeUseCase = verifyResetCodeUseCase,
       _resetPasswordUseCase = resetPasswordUseCase,
       super(const AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<SignUpEvent>(_onSignUp);
    on<LogoutEvent>(_onLogout);
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<VerifyResetCodeEvent>(_onVerifyResetCode);
    on<ResetPasswordEvent>(_onResetPassword);
  }

  final LoginUseCase _loginUseCase;
  final SignupUseCase _signupUseCase;
  final LogoutUseCase _logoutUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading(AuthAction.login));

    final result = await _loginUseCase(credentials: event.credentials);
    result.fold(
      (failure) => emit(
        AuthError(
          message: failure.message,
          action: AuthAction.login,
          type: _mapFailureType(failure),
        ),
      ),
      (_) => emit(const AuthLoginSuccess()),
    );
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading(AuthAction.signUp));

    final result = await _signupUseCase(data: event.data);
    result.fold(
      (failure) => emit(
        AuthError(
          message: failure.message,
          action: AuthAction.signUp,
          type: _mapFailureType(failure),
        ),
      ),
      (_) => emit(const AuthSignUpSuccess()),
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading(AuthAction.logout));

    final result = await _logoutUseCase();
    result.fold(
      (failure) => emit(
        AuthError(
          message: failure.message,
          action: AuthAction.logout,
          type: _mapFailureType(failure),
        ),
      ),
      (_) => emit(const AuthLogoutSuccess()),
    );
  }

  Future<void> _onForgotPassword(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(AuthAction.forgotPassword));

    final result = await _forgotPasswordUseCase(email: event.email);
    result.fold(
      (failure) => emit(
        AuthError(
          message: failure.message,
          action: AuthAction.forgotPassword,
          type: _mapFailureType(failure),
        ),
      ),
      (verificationCode) => emit(
        AuthForgotPasswordSuccess(
          email: event.email,
          verificationCode: verificationCode,
        ),
      ),
    );
  }

  Future<void> _onVerifyResetCode(
    VerifyResetCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(AuthAction.verifyResetCode));

    final result = await _verifyResetCodeUseCase(
      email: event.email,
      code: event.code,
    );

    result.fold(
      (failure) => emit(
        AuthError(
          message: failure.message,
          action: AuthAction.verifyResetCode,
          type: _mapFailureType(failure),
        ),
      ),
      (_) => emit(
        AuthVerifyResetCodeSuccess(email: event.email, code: event.code),
      ),
    );
  }

  Future<void> _onResetPassword(
    ResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(AuthAction.resetPassword));

    final result = await _resetPasswordUseCase(
      email: event.email,
      code: event.code,
      newPassword: event.newPassword,
      confirmPassword: event.confirmPassword,
    );

    result.fold(
      (failure) => emit(
        AuthError(
          message: failure.message,
          action: AuthAction.resetPassword,
          type: _mapFailureType(failure),
        ),
      ),
      (_) => emit(const AuthResetPasswordSuccess()),
    );
  }

  AuthFailureType _mapFailureType(Failures failure) {
    if (failure is ServerFailure) {
      return AuthFailureType.server;
    }

    if (failure is OfflineFailure) {
      return AuthFailureType.offline;
    }

    return AuthFailureType.auth;
  }
}
