import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {}

class SeverFailure extends Failures {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmptyCacheFailure extends Failures {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class OfflineFailure extends Failures {
  @override
  List<Object?> get props => [];
}

class AuthFailure extends Failures {
  final String message;

  AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
