import 'dart:typed_data';

abstract class SearchUserEntity {
  final int id;
  final String name;
  final String city;
  final String country;
  final int commonFriends;
  final Uint8List imageData;

  SearchUserEntity(
      {required this.id,
      required this.name,
      required this.city,
      required this.country,
      required this.commonFriends,
      required this.imageData});
}
