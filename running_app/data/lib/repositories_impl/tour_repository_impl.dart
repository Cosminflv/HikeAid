import 'dart:convert';
import 'dart:typed_data';

import 'package:domain/repositories/tour_repository.dart';
import 'package:shared/domain/tour_entity.dart';

import 'package:shared/domain/tour_file_entity.dart';
import 'package:http/http.dart' as http;

class TourRepositoryImpl extends TourRepository {
  //TODO: Change to openAPI instance
  //final Supabase _supabaseInstance;

  TourRepositoryImpl();

  @override
  Future<bool> insertTour({required TourEntity tour, required Uint8List previewImageBytes}) async {
    try {
      final fileName = '${tour.authorId}${DateTime.now().millisecondsSinceEpoch}${tour.previewImageUrl.hashCode}.jpg';
      final imageUploadUrl = Uri.parse('https://api.cloudinary.com/v1_1/desccolsj/image/upload');
      final request = http.MultipartRequest('POST', imageUploadUrl)
        ..fields['upload_preset'] = 'hikeaid'
        ..files.add(http.MultipartFile.fromBytes(
          'file',
          previewImageBytes,
          filename: fileName,
        ));
      final response = await request.send();
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      final _uploadedUrl = jsonMap['url'] as String?;

      // Next upload the tour to the database

      return true;
    } catch (e) {
      print("Error inserting tour: $e");
      return false;
    }
  }

  @override
  Future<List<TourEntity>?> readOwnTours() async {
    // final session = _supabaseInstance.client.auth.currentSession;

    // if (session == null) return null;

    // _supabaseInstance.client.rest.setAuth(session.accessToken);
    // final id = session.user.id;

    // final response = await _supabaseInstance.client.rest
    //     .from('tours')
    //     .select('*, profiles!public_tours_author_id_fkey(*)')
    //     .eq('author_id', id);
    // return response.map((json) => TourEntityImpl.fromJson(json)).toList();
  }

  @override
  Future<List<TourEntity>?> readTours() async {
    // final session = _supabaseInstance.client.auth.currentSession;

    // if (session == null) return null;

    // _supabaseInstance.client.rest.setAuth(session.accessToken);

    // final response = await _supabaseInstance.client.rest
    //     .from('tours')
    //     .select('*, profiles!public_tours_author_id_fkey(*)')
    //     .eq('is_public', true);

    // return response.map((json) => TourEntityImpl.fromJson(json)).toList();
  }

  @override
  Future<void> delete(TourEntity tour) async {
    // final session = _supabaseInstance.client.auth.currentSession;

    // if (session == null) return;

    // _supabaseInstance.client.rest.setAuth(session.accessToken);

    // await _supabaseInstance.client.rest.from('tours').delete().eq('id', tour.id);
  }

  @override
  Future<void> rename({required TourEntity tour, required String newName}) async {
    // final session = _supabaseInstance.client.auth.currentSession;

    // if (session == null) return;

    // _supabaseInstance.client.rest.setAuth(session.accessToken);

    // await _supabaseInstance.client.rest.from('tours').update({'name': newName}).eq('id', tour.id);
  }

  @override
  Future<void> setVisibility({required TourEntity tour, required bool isPublic}) async {
    // final session = _supabaseInstance.client.auth.currentSession;

    // if (session == null) return;

    // _supabaseInstance.client.rest.setAuth(session.accessToken);

    // await _supabaseInstance.client.rest.from('tours').update({'is_public': isPublic}).eq('id', tour.id);
  }

  @override
  void registerTourSharingURLReceivedCallback(void Function(TourEntity? tour) onTourReceived) {
    // StreamSubscription? authLinkSubscription;
    // authLinkSubscription = AppLinks().uriLinkStream.listen((uri) async {
    //   final queryParams = uri.queryParameters;

    //   if (uri.pathSegments.contains('share_tour')) {
    //     final id = queryParams['tour'];
    //     if (id == null) return;

    //     final tour = await _getTourById(id);
    //     onTourReceived(tour);
    //   }
    // });
  }

  Future<TourEntity?> _getTourById(String id) async {
    // final session = _supabaseInstance.client.auth.currentSession;

    // if (session == null) return null;

    // _supabaseInstance.client.rest.setAuth(session.accessToken);

    // try {
    //   final res = await _supabaseInstance.client.rest
    //       .from('tours')
    //       .select('*, profiles!public_tours_author_id_fkey(*)')
    //       .eq('id', id);
    //   if (res.isEmpty) return null;

    //   return TourEntityImpl.fromJson(res.first);
    // } catch (e) {
    //   return null;
    // }
  }

  @override
  Future<TourEntity?> checkForTourSharingURL() async {
    // final uri = await AppLinks().getInitialLink();

    // if (uri == null) return null;

    // final queryParams = uri.queryParameters;

    // if (uri.pathSegments.contains('share_tour')) {
    //   final id = queryParams['tour'];
    //   if (id == null) return null;

    //   return await _getTourById(id);
    // }
    // return null;
  }

  @override
  Future<List<String>?> insertTourImages({required TourEntity tour, required List<TourFileEntity> images}) async {
    // final session = _supabaseInstance.client.auth.currentSession;

    // if (session == null) return null;

    // _supabaseInstance.client.rest.setAuth(session.accessToken);

    // try {
    //   final imagesToInsert = images
    //       .map((e) => {
    //             'distance_on_tour': e.distance,
    //             'tour_id': tour.id,
    //           })
    //       .toList();
    //   final res = await _supabaseInstance.client.rest.from('tour_files').insert(imagesToInsert).select('file_name');
    //   if (res.isEmpty) return null;

    //   return res.map((e) => e['file_name'] as String).toList();
    // } catch (e) {
    //   return null;
    // }
  }

  @override
  Future<List<TourFileEntity>?> readTourFiles(TourEntity tour) async {
    //   final session = _supabaseInstance.client.auth.currentSession;

    //   if (session == null) return null;

    //   _supabaseInstance.client.rest.setAuth(session.accessToken);

    //   try {
    //     final res = await _supabaseInstance.client.rest.from('tour_files').select().eq('tour_id', tour.id);
    //     if (res.isEmpty) return null;

    //     return res.map((e) => TourFileEntityImpl.fromJson(e)).toList();
    //   } catch (e) {
    //     return null;
    //   }
    // }
  }
}
