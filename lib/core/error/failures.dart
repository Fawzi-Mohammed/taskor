import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  const Failures(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failures {
  const ServerFailure([super.message = 'Server error']);
}

class EmptyCacheFailure extends Failures {
  const EmptyCacheFailure([super.message = 'No cached data']);
}

class OfflineFailure extends Failures {
  const OfflineFailure([super.message = 'No internet connection']);
}

class AuthFailure extends Failures {
  const AuthFailure([super.message = 'Authentication failed']);
}
