import 'package:equatable/equatable.dart';


class User extends Equatable {
  const User({
    required this.email,
    required this.hourlyRate,
  });

  final String email;
  final double hourlyRate;

  @override
  List<Object?> get props => [email, hourlyRate];
}
