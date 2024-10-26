import 'package:domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AuthSessionEntity extends Equatable {
  final UserEntity user;
  final String accessToken;

  AuthSessionEntity({required this.user, required this.accessToken});

  @override
  List<Object?> get props => [user];
}
