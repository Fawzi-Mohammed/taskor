import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskor/core/services/local/shared_pref_service.dart';
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

  sl.registerLazySingleton<OnboardingLocalDataSource>(() => OnboardingLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<OnboardingRepository>(() => OnboardingRepositoryImpl(sl()));
  sl.registerLazySingleton(() => CheckOnboardingStatusUseCase(sl()));
  sl.registerLazySingleton(() => CompleteOnboardingUseCase(sl()));
  sl.registerFactory(() => SplashOnboardingBloc(checkStatus: sl(), completeOnboarding: sl()));
}
