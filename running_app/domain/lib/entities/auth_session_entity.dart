import 'package:domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AuthSessionEntity extends Equatable {
  final UserEntity user;

  AuthSessionEntity({required this.user});

  @override
  List<Object?> get props => [user];
}
