import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for AlertApi
void main() {
  final instance = Openapi().getAlertApi();

  group(AlertApi, () {
    //Future apiAlertAddAlertPost(DateTime createdAt, DateTime expiresAt, String title, String description, String alertType, bool isActive, double latitude, double longitude, { MultipartFile imageFile }) async
    test('test apiAlertAddAlertPost', () async {
      // TODO
    });

  });
}
