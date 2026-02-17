import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskor/core/config/constants/request_constants.dart';
import 'package:taskor/core/services/local/shared_pref_service.dart';
import 'package:taskor/core/services/remote/dio_client.dart';
import 'package:taskor/core/services/remote/dio_handler.dart';
import 'package:taskor/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:taskor/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:taskor/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:taskor/features/auth/domain/repositories/auth_repository.dart';
import 'package:taskor/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:taskor/features/auth/domain/usecases/login_usecase.dart';
import 'package:taskor/features/auth/domain/usecases/logout_usecase.dart';
import 'package:taskor/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:taskor/features/auth/domain/usecases/signup_usecase.dart';
import 'package:taskor/features/auth/domain/usecases/verify_reset_code_usecase.dart';
import 'package:taskor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskor/features/splash_onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:taskor/features/splash_onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:taskor/features/splash_onboarding/domain/repositories/onboarding_repository.dart';
import 'package:taskor/features/splash_onboarding/domain/usecases/check_onboarding_status_usecase.dart';
import 'package:taskor/features/splash_onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:taskor/features/splash_onboarding/presentation/bloc/splash_onboarding_bloc.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  sl.registerLazySingleton<SharedPrefService>(() => SharedPrefService(sl()));

  sl.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => CheckOnboardingStatusUseCase(sl()));
  sl.registerLazySingleton(() => CompleteOnboardingUseCase(sl()));
  sl.registerFactory(
    () => SplashOnboardingBloc(checkStatus: sl(), completeOnboarding: sl()),
  );

  sl.registerLazySingleton(() => DioClient(baseUrl: RequestConstants.baseUrl));
  sl.registerLazySingleton(() => DioHandler(sl()));

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );

  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignupUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => VerifyResetCodeUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));

  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      signupUseCase: sl(),
      logoutUseCase: sl(),
      forgotPasswordUseCase: sl(),
      verifyResetCodeUseCase: sl(),
      resetPasswordUseCase: sl(),
    ),
  );
}
