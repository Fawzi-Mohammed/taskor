import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.name,
    required this.username,
    required this.email,
    this.hourlyRate,
  });

  final String name;
  final String username;
  final String email;
  final double? hourlyRate;

  @override
  List<Object?> get props => [name, username, email, hourlyRate];
}
