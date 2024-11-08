abstract class SearchUserEntity {
  final int id;
  final String name;
  final String city;
  final String country;
  final int commonFriends;

  SearchUserEntity(
      {required this.id, required this.name, required this.city, required this.country, required this.commonFriends});
}
