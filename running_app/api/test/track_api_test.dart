import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for TrackApi
void main() {
  final instance = Openapi().getTrackApi();

  group(TrackApi, () {
    //Future apiTrackIdUploadTrackPost(String id, { TrackDto trackDto }) async
    test('test apiTrackIdUploadTrackPost', () async {
      // TODO
    });

    //Future<BuiltList<TrackDto>> apiTrackIdUserTracksGet(String id, { int userId }) async
    test('test apiTrackIdUserTracksGet', () async {
      // TODO
    });

  });
}
