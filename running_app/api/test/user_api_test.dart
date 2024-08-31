import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for UserApi
void main() {
  final instance = Openapi().getUserApi();

  group(UserApi, () {
    //Future apiUserAcceptFriendRequestPost({ int requestId }) async
    test('test apiUserAcceptFriendRequestPost', () async {
      // TODO
    });

    //Future apiUserDeclineFriendRequestPost({ int requestId }) async
    test('test apiUserDeclineFriendRequestPost', () async {
      // TODO
    });

    //Future apiUserGet() async
    test('test apiUserGet', () async {
      // TODO
    });

    //Future<BuiltList<FriendshipModel>> apiUserGetFriendRequestsGet() async
    test('test apiUserGetFriendRequestsGet', () async {
      // TODO
    });

    //Future apiUserIdDeleteProfilePicturePost(String id, { int userId }) async
    test('test apiUserIdDeleteProfilePicturePost', () async {
      // TODO
    });

    //Future<String> apiUserIdGetProfilePictureGet(String id, { int userId }) async
    test('test apiUserIdGetProfilePictureGet', () async {
      // TODO
    });

    //Future apiUserIdUploadProfilePictureBase64Post(String id, { int userId, String body }) async
    test('test apiUserIdUploadProfilePictureBase64Post', () async {
      // TODO
    });

    //Future apiUserLoginPost({ LoginDto loginDto }) async
    test('test apiUserLoginPost', () async {
      // TODO
    });

    //Future apiUserPost({ UserModel userModel }) async
    test('test apiUserPost', () async {
      // TODO
    });

    //Future apiUserSendFriendRequestPost({ int requesterId, int receiverId }) async
    test('test apiUserSendFriendRequestPost', () async {
      // TODO
    });

  });
}
