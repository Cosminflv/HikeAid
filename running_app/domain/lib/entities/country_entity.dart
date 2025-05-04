import 'package:equatable/equatable.dart';

abstract class CountryEntity extends Equatable {
  final String isoCode;
  final String? name;

  const CountryEntity({required this.isoCode, this.name});

  @override
  List<Object?> get props => [isoCode];
}
