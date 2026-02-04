import 'package:equatable/equatable.dart';

class SignupData extends Equatable {
  const SignupData({
    required this.name,
    required this.email,
    required this.password,
    required this.hourlyRate,
  });

  final String name;
  final String email;
  final String password;
  final double hourlyRate;

  @override
  List<Object?> get props => [name, email, password, hourlyRate];
}
