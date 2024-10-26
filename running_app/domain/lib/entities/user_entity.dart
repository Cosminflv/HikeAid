import 'package:equatable/equatable.dart';

abstract class UserEntity extends Equatable {
  final int id;

  UserEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
