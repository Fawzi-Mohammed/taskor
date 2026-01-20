import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required LoginUseCase loginUseCase,
    required SignupUseCase signupUseCase,
  }) : _login = loginUseCase,
       _signup = signupUseCase,
       super(const AuthInitial()) {
    on<LoginSubmitted>(_onLogin);
    on<SignupSubmitted>(_onSignup);
  }

  final LoginUseCase _login;
  final SignupUseCase _signup;

  Future<void> _onLogin(LoginSubmitted e, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await _login(credentials: e.credentials);
    result.fold(
      (f) => emit(const AuthFailureState('Login failed')),
      (_) => emit(const AuthSuccess()),
    );
  }

  Future<void> _onSignup(SignupSubmitted e, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await _signup(data: e.data);
    result.fold(
      (f) => emit(const AuthFailureState('Signup failed')),
      (_) => emit(const AuthSuccess()),
    );
  }
}
