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

class LoginFailure extends Failures {
  @override
  List<Object?> get props => [];
}
