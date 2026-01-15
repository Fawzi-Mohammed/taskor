# taskor

Taskor is a modern Flutter app for freelancers and companies to manage development work. It keeps every developer’s tasks and projects organized while tracking total earnings and total hours so teams always know where time and money go.

## Use cases

- Centralize project and task tracking for individual developers or full teams.
- Add, update, and delete tasks to keep work items current and clear.
- Create, update, and delete projects while monitoring overall progress.
- Monitor total hours and total earnings to stay on budget and on schedule.
- Deliver everything with a polished, modern UI/UX suitable for client-facing workflows.

## Getting started

- Install Flutter and set up your environment: <https://docs.flutter.dev/get-started/install>
- Run `flutter pub get` to install dependencies.
- Launch the app with `flutter run` on your desired device or emulator.

## Architecture (Clean Architecture)

Taskor follows a feature-first Clean Architecture layout:

- **Presentation**: UI + state management (for example, `SplashOnboardingBloc` in `lib/features/splash_onboarding/presentation`).
- **Domain**: Pure business rules and use cases (for example, `CheckOnboardingStatusUseCase` and `CompleteOnboardingUseCase` in `lib/features/splash_onboarding/domain`).
- **Data**: Repositories and data sources (for example, `OnboardingRepositoryImpl` and `OnboardingLocalDataSourceImpl` in `lib/features/splash_onboarding/data`).

This keeps UI independent from data details and makes features easier to test and evolve.

## Shared preferences (local storage)

Local persistence uses a small wrapper around `SharedPreferences`:

- `SharedPrefService` in `lib/core/services/local/shared_pref_service.dart` provides simple `set/get` helpers for `bool` and `String`.
- The onboarding flow uses this service via its local data source to store whether onboarding is completed.

## Dependency injection

Dependencies are wired up with `get_it`:

- `initServiceLocator()` in `lib/core/di/service_locator.dart` registers `SharedPreferences`, `SharedPrefService`, onboarding data sources, repositories, use cases, and `SplashOnboardingBloc`.
- `main()` awaits `initServiceLocator()` before running the app so all services are ready.

## Recent changes (Onboarding/Splash)

### Onboarding

- Navigation now uses path-based routing to reach the main shell (`/main`) after onboarding completes.
- The change removes the previous reliance on a missing named route, preventing `namedLocation`/`goNamed` runtime errors.
- Completion still dispatches `OnboardingCompletedEvent` from the onboarding screen and is handled by `SplashOnboardingBloc`.

### Splash flow

- `SplashPage` continues to listen for `ShowOnboarding` vs `NavigateToHome` from `SplashOnboardingBloc`.
- Both branches now align on path-based navigation (`/onboarding` or `/main`) for consistent routing behavior.
