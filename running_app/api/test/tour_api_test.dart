import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for TourApi
void main() {
  final instance = Openapi().getTourApi();

  group(TourApi, () {
    //Future apiTourIdUploadTourPost(String id, { TourDto tourDto }) async
    test('test apiTourIdUploadTourPost', () async {
      // TODO
    });

    //Future<BuiltList<TourDto>> apiTourIdUserToursGet(String id, { int userId }) async
    test('test apiTourIdUserToursGet', () async {
      // TODO
    });

  });
}
