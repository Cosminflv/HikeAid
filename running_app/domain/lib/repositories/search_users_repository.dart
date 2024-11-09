import 'package:domain/entities/search_user_entity.dart';

abstract class SearchUsersRepository {
  Future<void> search(
      {required String text, required int userId, required Function(List<SearchUserEntity> p1) onResult});

  void sendFriendRequest({required int requesterId, required int receiverId});
}
