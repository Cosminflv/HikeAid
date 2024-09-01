import 'package:equatable/equatable.dart';

abstract class UserEntity extends Equatable {
  final int id;
  final String username;

  UserEntity({required this.id, required this.username});

  @override
  List<Object?> get props => [id, username];
}
