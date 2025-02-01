//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import 'package:openapi/src/api_util.dart';

class AlertApi {

  final Dio _dio;

  final Serializers _serializers;

  const AlertApi(this._dio, this._serializers);

  /// apiAlertAddAlertPost
  /// 
  ///
  /// Parameters:
  /// * [createdAt] 
  /// * [expiresAt] 
  /// * [title] 
  /// * [description] 
  /// * [alertType] 
  /// * [isActive] 
  /// * [latitude] 
  /// * [longitude] 
  /// * [imageFile] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future]
  /// Throws [DioException] if API call or serialization fails
  Future<Response<void>> apiAlertAddAlertPost({ 
    required DateTime createdAt,
    required DateTime expiresAt,
    required String title,
    required String description,
    required String alertType,
    required bool isActive,
    required double latitude,
    required double longitude,
    MultipartFile? imageFile,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/Alert/AddAlert';
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'Bearer',
            'name': 'Bearer',
          },
        ],
        ...?extra,
      },
      contentType: 'multipart/form-data',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      _bodyData = FormData.fromMap(<String, dynamic>{
        r'CreatedAt': encodeFormParameter(_serializers, createdAt, const FullType(DateTime)),
        r'ExpiresAt': encodeFormParameter(_serializers, expiresAt, const FullType(DateTime)),
        r'Title': encodeFormParameter(_serializers, title, const FullType(String)),
        r'Description': encodeFormParameter(_serializers, description, const FullType(String)),
        r'AlertType': encodeFormParameter(_serializers, alertType, const FullType(String)),
        r'IsActive': encodeFormParameter(_serializers, isActive, const FullType(bool)),
        r'Latitude': encodeFormParameter(_serializers, latitude, const FullType(double)),
        r'Longitude': encodeFormParameter(_serializers, longitude, const FullType(double)),
        if (imageFile != null) r'ImageFile': imageFile,
      });

    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return _response;
  }

}
